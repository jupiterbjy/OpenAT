"""
Converts texture.scr script file seemingly defining blending shader operation to
JSON format, allowing runtime generation of corresponding materials
"""

from argparse import ArgumentParser
from typing import Iterator, Tuple, Generator, Dict
import pathlib
import json


ROOT = pathlib.Path(__file__).parent
DEFAULT_PATH = pathlib.Path(r"C:\Program Files (x86)\Armada Tanks\BaseT")
WRITE_ENCODING = "utf8"
READ_ENCODING = "windows 1251"

OUTPUT = ROOT / "output"
OUTPUT.mkdir(exist_ok=True)


# Devs set SRCBLEND_SRCALPHA on JPG file(?) - which creates undefiend behaviors in godot engine.
# workaround for this exception case
JPG_ALPHA_BLACKLIST = {
    "TANKPL1"
}


class DummyData(Exception):
    pass


class FileNameTranslator:
    """
    Stores actual image's file name.

    Dev mixed the lower & upper case randomly, which result in unplayable situation
    in case-sensitive systems. We need to correct it.
    """

    translation_dict: Dict[str, str] = {}

    @classmethod
    def populate(cls, game_path: pathlib.Path):
        """Search for image files and populate translation dict with lowercase names."""

        whitelist = {".jpg", ".png", ".bmp"}

        for img_path in (game_path / "Texture").iterdir():

            if img_path.is_dir() or img_path.suffix.lower() not in whitelist:
                continue

            cls.translation_dict[img_path.name.lower()] = img_path.name

    @classmethod
    def translate(cls, file_name: str) -> str:
        try:
            return cls.translation_dict[file_name.lower()]
        except KeyError as err:
            raise DummyData() from err


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
                alpha = False if name in JPG_ALPHA_BLACKLIST else True
            case ["SrcBlend_SRCCOLOR"]:
                blend_add = True
            case ["LoadFile", *param]:
                # Only take first filename, strip quotes and leave name only
                file_name = param[0].strip("\"").split("\\\\")[-1]
            case ["}"]:
                break

    return name, {"idx": idx, "alpha": alpha, "blend_add": blend_add, "file": FileNameTranslator.translate(file_name)}


def parse_gen(line_iter: Iterator[str]) -> Generator[None, Tuple[int, str, dict], None]:
    while True:
        try:
            yield _parse_single(line_iter)

        except DummyData:
            print("Skipping dummy data")

        except StopIteration:
            return


def main(args):
    FileNameTranslator.populate(args.base_t_dir)

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
