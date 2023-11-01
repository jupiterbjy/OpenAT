"""
Converts texture.scr script file seemingly defining blending shader operation to
JSON format, allowing runtime generation of corresponding materials
"""

from argparse import ArgumentParser
from typing import Iterator, Tuple, Generator
import pathlib
import json


ROOT = pathlib.Path(__file__).parent
DEFAULT_PATH = pathlib.Path(r"C:\Program Files (x86)\Armada Tanks\BaseT")
WRITE_ENCODING = "utf8"
READ_ENCODING = "windows 1251"

OUTPUT = ROOT / "output"
OUTPUT.mkdir(exist_ok=True)


# devs mixed the lower & upper case randomly, which result in unplayable situation
# in case-sensitive systems. We need to correct it.
JPEG_FILE_NAME_FIXES = {
    "sky.jpg": "Sky.JPG",
    "Terr_Egypt_Obj.jpg": "Terr_Egypt_Obj.JPG",
    "Terr_Forest_Pac_Obj.jpg": "Terr_Forest_Pac_Obj.JPG",
    "Terr_Ice.jpg": "Terr_Ice.JPG",
    "Terr_Snow.jpg": "Terr_Snow.JPG",
    "Terr_Tundra.jpg": "Terr_Tundra.JPG",
}


def _fix_filename(name: str) -> str:
    return JPEG_FILE_NAME_FIXES[name] if name in JPEG_FILE_NAME_FIXES else name


def _safe_read(p: pathlib.Path) -> str:
    """First try to read in system default, then try UTF8"""

    try:
        return p.read_text()
    except UnicodeDecodeError:
        return p.read_text(READ_ENCODING)


def _find_prefix(iterator: Iterator[str], prefix: str):

    for line in iterator:
        line = line.strip()

        if line.startswith(prefix):
            return line.split()

    raise StopIteration


def _parse_single(line_iter: Iterator[str]) -> Tuple[str, dict]:
    """Parse single texture entry"""

    # parse name & index
    _, idx, name, _ = _find_prefix(line_iter, "texture")
    idx = int(idx)
    name = name.strip("\"")

    # parse other lines
    alpha = False
    blend_add = False
    file_name = ""

    for line in line_iter:
        match line.strip().split(" "):
            case ["SrcBlend_SRCALPHA"]:
                alpha = True
            case ["SrcBlend_SRCCOLOR"]:
                blend_add = True
            case ["LoadFile", *param]:
                # Only take first filename, strip quotes and leave name only
                file_name = param[0].strip("\"").split("\\\\")[-1]
            case ["}"]:
                break

    return name, {"idx": idx, "alpha": alpha, "blend_add": blend_add, "file": _fix_filename(file_name)}


def parse_gen(line_iter: Iterator[str]) -> Generator[None, Tuple[int, str, dict], None]:
    while True:
        try:
            yield _parse_single(line_iter)
        except StopIteration:
            return


def main(args):
    script_root = args.base_t_dir / "Script"

    base = script_root / "texture.scr"
    map_overrides = [
        p for p in script_root.iterdir() if p.name.startswith("texture-")
    ]

    base_dict = {
        name: data for name, data in parse_gen(iter(_safe_read(base).splitlines()))
    }

    # save base
    base_path = OUTPUT / "texture.json"
    base_path.write_text(json.dumps(base_dict, indent=2), WRITE_ENCODING)

    print("Written Base texture file at", base_path.as_posix())

    for p in map_overrides:
        map_dict = {
            name: data for name, data in parse_gen(iter(_safe_read(p).splitlines()))
        }

        map_path = OUTPUT / f"{p.stem}.json"
        map_path.write_text(json.dumps(map_dict, indent=2), WRITE_ENCODING)

        print("Written Override texture file at", map_path.as_posix())


if __name__ == '__main__':
    _parser = ArgumentParser()
    _parser.add_argument(
        "base_t_dir",
        metavar="F",
        type=pathlib.Path,
        default=None,
        nargs="?",
        help="Directory path of BaseT"
    )

    _args = _parser.parse_args()

    # check if argument is missing
    if _args.base_t_dir is None:
        # if game is installed in default location, use that data
        if DEFAULT_PATH.exists():
            print(f"Using Default installation at '{DEFAULT_PATH.as_posix()}'")
            _args.base_t_dir = DEFAULT_PATH
        else:
            # we can't proceed, show usage instead
            _parser.print_usage()
            exit()

    main(_args)
