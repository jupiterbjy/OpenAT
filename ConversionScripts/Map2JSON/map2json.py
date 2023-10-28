"""
Script for (mostly) converting Armada Tanks' *.map stage definition format

TODO: change hard-coded map select positions to use BaseT/Map/maps.txt
"""
import itertools
import pathlib
import json
import functools
from typing import Generator, Tuple, Iterator, List, Dict

ROOT = pathlib.Path(__file__).parent
DEFAULT_PATH = pathlib.Path(r"C:\Program Files (x86)\Armada Tanks\BaseT")

WRITE_ENCODING = "utf8"
READ_ENCODINGS = ["windows 1251", "OEM 866"]

OUTPUT = ROOT / "output"
OUTPUT.mkdir(exist_ok=True)


def _safe_read(path: pathlib.Path, encoding=None) -> str:
    try:
        return path.read_text(encoding)

    except UnicodeDecodeError:
        # SAND/m5.map has letter ‘ in file, which requires windows-1251

        for encoding in READ_ENCODINGS:
            try:
                print("Trying", encoding)
                return path.read_text(encoding)
            except UnicodeDecodeError:
                continue


def find_prefix(line_iter: Iterator[str], search_tgt: str, return_line=False, strip=True) -> str:
    """Forward iterator until search_tgt substring is found, then returns line"""

    for line in line_iter:
        print(f"[DEBUG] {line}")

        if strip:
            line = line.strip()

        if search_tgt in line:
            # we'll drop any secondary parameter, mostly it's dummy data
            # (i.e. RUIN/m1.map gametype BF HT only takes BF)
            return line if return_line else line.split(" ")[1]

    raise StopIteration


def _parse_next_map(line_iter: Iterator[str]) -> str:
    """Returns empty string if there's no next map, else returns map name"""

    # nextmap 0
    # nextmap 1 BaseT\Map\SAND\m3.map

    line = find_prefix(line_iter, "nextmap", True).removeprefix("nextmap ")
    return "" if line[0] == "0" else line.split(" ")[1].split("\\")[-1]


def _parse_flag(line_iter: Iterator[str]) -> Tuple[int, int, str, str]:
    """Returns parsed flag setting"""

    # flag 10 4 FLAGI FLAG123 FLAG FLAG
    # _, tile coordinates, model name, model texture, dummy otherwise

    line = find_prefix(line_iter, "flag", True).removeprefix("flag ").split(" ")
    return int(line[0]), int(line[1]), line[2], line[3]


def _block_gen(line_iter: Iterator[str], prefix, suffix, split=True) -> Generator:
    """Parse multiline blocks enclosed with braces"""

    find_prefix(line_iter, prefix)

    for line in line_iter:
        line = line.strip()

        if suffix in line:
            break

        if not line:
            continue

        yield line.split(" ")[1:] if split else line


def _parse_event(line_iter: Iterator[str]) -> List[Tuple[int, int, int]]:
    """Parse event objects"""

    # evob 6 4 16

    return [
        (int(obj_id), int(x), int(y))
        for obj_id, x, y in _block_gen(line_iter, "eventobj", "endeventobj")
    ]


def _parse_respawn(line_iter: Iterator[str]) -> List[Tuple[int, int, int]]:
    """Parse respawn positions"""

    # rsp 0 8 5

    return [
        (int(idx), int(x), int(y))
        for idx, x, y in _block_gen(line_iter, "respawn", "endrespawn")
    ]


def _parse_terr_type(line_iter: Iterator[str]) -> Dict[str, List[str]]:
    """Parse terrain types"""

    # type 0 TERR0 NWF

    return {
        idx: [model, args]
        for idx, model, args in _block_gen(line_iter, "terrtype", "endterr")
    }


def _parse_wall(line_iter: Iterator[str]) -> List[str]:
    """Parse wall positions"""

    return [
        # strip ln " prefix and trailing "
        line.removeprefix("ln \"")[:-1]
        for line in _block_gen(line_iter, "wall", "endwall", False)
    ]


def _parse_terr(line_iter: Iterator[str], prefix="terr") -> List[str]:
    """Parse base terrain"""

    # return excluding prefix(ln )
    return [line[3:] for line in _block_gen(line_iter, prefix, "endterr", False)]


def _parse_terr_2(line_iter: Iterator[str]) -> List[str]:
    """Parse base terrain"""

    return _parse_terr(line_iter, "terr2")


def _parse_tank_n_size(line_iter: Iterator[str]) -> Tuple[int, str, Tuple[int, int]]:
    """Parse tank string & size string, returning enemy count, spawn sequence and map size."""
    # kinda messy function due to how iterator works

    lines = [find_prefix(line_iter, "tank", True, False)]

    # append lines until & including size line
    for line in line_iter:
        lines.append(line)
        if "size" in line:
            break

    # join tank lines
    spawn_sequence = " ".join(lines[:-1])

    # split total count from spawn sequence
    count = int(spawn_sequence.split(" ")[1])
    spawn_sequence = spawn_sequence.removeprefix(f"tank {count}").lstrip()

    # parse size
    size = lines[-1].split(" ")[1:3]

    return count, spawn_sequence, (int(size[0]), int(size[1]))


def parse_map_config(line_iter: Iterator[str]) -> dict:
    find = functools.partial(find_prefix, line_iter)

    # noinspection PyDictCreation
    config = {
        # not sure what 'map 3' means, seems all same through file
        # "map": int(find("map")),

        "cost": int(find("cost")),
        "game_type": find("gametype"),

        # texture group for overriding main texture definitions (texture.scr)
        "texture_override": find("texscript").split("\\")[-1].removesuffix(".scr"),

        # ignoring mdlscript - there's only one model definitions on release

        # weather - NONE / RAIN / SNOW - there is sand dummy data too.
        "weather": find("weather"),

        # ignoring fog - all fogs are 0
        # ignoring music - no other music was used on release

        # next map if any, otherwise blank str
        "next_map": _parse_next_map(line_iter),

        "items": find("items"),
        "help": find("help", True).removeprefix("help "),
        "message": find("message"),

        # adding key in advance so JSON order stays intact
        # very counter-intuitive and illogical!
        "enemy_count": _parse_tank_n_size(line_iter),
        "spawn_sequence": None,
        "size": None,

        "flag": _parse_flag(line_iter),
        "event_obj": _parse_event(line_iter),
        "respawn": _parse_respawn(line_iter),

        "terrain_type": _parse_terr_type(line_iter),
        "wall": _parse_wall(line_iter),
        "terrain": _parse_terr(line_iter),
        "terrain_2": _parse_terr_2(line_iter),
    }

    config["enemy_count"], config["spawn_sequence"], config["size"] = config["enemy_count"]

    return config


def alt_split(line: str) -> List[str]:
    """Split at whitespace, while not breaking double quotes"""

    parts = []
    stack = ""
    is_in_quote = False

    for char in line:
        match (char, is_in_quote):

            case " ", False:
                if not stack:
                    continue

                parts.append(stack)
                stack = ""

            case "\"", False:
                is_in_quote = True

            case "\"", True:
                is_in_quote = False
                parts.append(stack)
                stack = ""

            case _:
                stack += char

    return parts


def parse_map_txt(line_iter: Iterator[str]) -> Dict:
    """Parses BaseT/Map/map.txt"""

    # first 8 lines are dummy
    dummy = [next(line_iter) for _ in range(8)]
    areas = []

    while True:
        try:
            area_line = find_prefix(line_iter, "episode", return_line=True)
        except StopIteration:
            break

        area_parts = alt_split(area_line)[2:]
        area_info = {
            "marker": (int(area_parts[0]), int(area_parts[1])),
            "name": area_parts[2],
            "texture": area_parts[3],
            "level": []
        }

        # parse stages
        for line in line_iter:
            line = line.strip()

            if not line:
                break

            line_parts = alt_split(line)[1:]
            area_info["level"].append(
                {
                    "dummy": line_parts[:3],
                    "name": line_parts[3],
                    "file": "/".join(line_parts[4].split("\\")[-2:]).replace(".map", ".json"),
                }
            )

        areas.append(area_info)

    return {"dummy": dummy, "areas": areas}


def main():
    # get map list definitions

    map_dir = DEFAULT_PATH / "Map"

    map_txt_path = map_dir / "maps.txt"

    # parse & write map txt
    map_txt = parse_map_txt(iter(_safe_read(map_txt_path).splitlines()))
    (OUTPUT / "maps.json").write_text(json.dumps(map_txt, indent=2), WRITE_ENCODING)

    for area in map_txt["areas"]:
        area_dir = OUTPUT / area["level"][0]["file"].split("/")[0]
        area_dir.mkdir(exist_ok=True)

        for idx, level in enumerate(area["level"], 1):
            file = map_dir / level["file"].replace(".json", ".map")
            print("Processing", file.as_posix())

            lines = _safe_read(file).splitlines()

            config = parse_map_config(iter(lines))

            # write level
            (area_dir / f"m{idx}.json").write_text(json.dumps(config, indent=2), WRITE_ENCODING)


if __name__ == '__main__':
    main()
