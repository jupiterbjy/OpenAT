"""
Converts dmt + model.scr format into common json format.
Drag n drop BaseT Directory to use! (or pass as argument manually)

: jupiterbjy@gmail.com
"""

import pathlib
import json
from argparse import ArgumentParser
from itertools import chain
from typing import Iterator, Sequence, Tuple


COMMON_KEYWORDS = {"Face", "TVertex", "TextureFaces", "Vertex", "TFace"}

ROOT = pathlib.Path(__file__).parent

OUTPUT = ROOT / "dtm2json_output"
OUTPUT.mkdir(exist_ok=True)

OUTPUT_LIST = OUTPUT / "_files.txt"
OUTPUT_LOOKUP = OUTPUT / "_lookup.json"

DEFAULT_PATH = pathlib.Path(r"C:\Program Files (x86)\Armada Tanks\BaseT")


def count_indent(line: str):
    combo = 0
    for char in line:
        if char == " ":
            combo += 1
        else:
            return combo


def recover_type(val: str):
    """Recover """
    # is int? there's no neg int in file, this is fine
    if val.isdigit():
        return int(val)

    # is it float? in this file, just period check is enough
    if "." in val:
        return float(val)

    # else just string, our time wasted!
    return val


def parse_recursive(string_iter: Iterator):
    """Recursive Dictionary translator of DTM file"""

    val = {}

    # starting with open bracket, get key name & indent level
    line = next(string_iter)
    key = line.strip(" \n{")
    indent_lvl = count_indent(line)

    for line in string_iter:

        # if matching close bracket is found, break & return result
        if "}" in line and count_indent(line) == indent_lvl:
            return key, val

        # if empty string with space and newline, pass
        if not line.strip():
            continue

        # if open bracket in line, recurse
        if "{" in line:
            child_key, child_val = parse_recursive(chain((line,), string_iter))
        else:
            child_key, *child_val = map(recover_type, line.strip().split())

            # if key is among these, set next first level in child as key.
            # totally fine to do so as these lines start with [type] [idx] [values].
            if child_key in COMMON_KEYWORDS:
                child_key, *child_val = child_val

        # add to dict, but store only a value if it's single value. Goose typing in action!
        if isinstance(child_val, Sequence) and len(child_val) == 1:
            val[child_key] = child_val[0]
        else:
            val[child_key] = child_val


def process_dtm(dtm_path: pathlib.Path) -> dict:
    """Translates DTM file into dict"""

    print(f"Processing {dtm_path.as_posix()}")

    # top level key is 'FILE' which we don't need
    _, parsed = parse_recursive(iter(dtm_path.read_text().splitlines()))

    frame_count = parsed["FileDesc"]["Frames"]
    print(f"Found {frame_count} frames")

    # reconstruct vertices per frames, found out there's more than 1 frame acting as a keyframes.
    # probably no need to do same for Texture maps, seems like every model uses just one.
    vertices = [
        [*parsed[f"Frame {frame_idx}"]["Vertices"].values()]
        for frame_idx in range(frame_count)
    ]

    # reconstruct to our taste
    # since python 3.7 dict retain insertion order. no need to worry about loosing index keys.
    output = {
        "vertices": vertices,
        "faces": [(v1, v2, v3) for v1, v2, v3, _, _, in parsed["Faces"].values()],
        "tex_vert": [*parsed["MapChannel 1"]["TextureVertices"].values()],
        "tex_loop": [*parsed["MapChannel 1"]["TextureFaces"].values()],
    }

    return output


def _regularize_scale_gen(scale_strings):

    # i.e. cases are  0.05 / 0.05 0.6 / 0.05 0.6 BACK(???)

    # mostly more than 1 are dummy model that doesn't exist
    # but this one exists: model 203 "BIGCRASH" {ScaleModel 0.029 0.025,  ... }

    # we'll just pass it and save for sake of accuracy, and use first value for 3 all axis.

    for val in scale_strings:
        try:
            yield float(val)
        except ValueError:
            yield val


def _find_line(iterator: Iterator[str], search_tgt: str):
    for line in iterator:
        if search_tgt in line:
            return line.strip().split()

    raise StopIteration


def parse_single(iterator: Iterator[str]) -> Tuple[int, str, Sequence, Sequence]:
    """Non-recursive Dictionary translator of SCR script. Returns (model idx, name, scale, file_name)"""

    # starting of definition
    # model 202 "BLMPSH" {
    _, idx, name, _ = _find_line(iterator, "{")
    idx = int(idx)
    name: str = name.strip("\"")

    # find scale, it could be single, double, triple or even string in scale. Maybe dummy data?
    # ScaleModel 0.05
    # ScaleModel 0.05 0.6
    # ScaleModel 0.05 0.66 0.6
    # ScaleModel 0.05 0.6 BACK
    _, *scale = _find_line(iterator, "Scale")
    scale = tuple(_regularize_scale_gen(scale))

    # find dtm file - there's some files with 2 entries - assuming it's alias or something...
    # LoadFileDTM "BaseT\\Model\\Event_Dzot_D.dtm"
    # LoadFileDTM "BaseT\\Model\\Bullet_Electro.dtm" Bullet_3.dtm
    _, *dtm = _find_line(iterator, "LoadFile")
    dtm[0] = dtm[0].strip("\"")
    dtm = [p.split("\\\\")[-1] for p in dtm]

    # Flexible Vertex Format mode Tex_1?
    # sdSetFVF T1
    # SetFVF T1
    # _, *dtm = _find_line(iterator, "SetFVF")

    return idx, name, scale, dtm


def parse_scr_gen(scr_path: pathlib.Path):
    line_iter = iter(scr_path.read_text().splitlines())

    while True:
        try:
            yield parse_single(line_iter)
        except StopIteration:
            return


def process_model_scr(scr_path: pathlib.Path) -> Tuple[dict, dict]:
    """Translates model.scr into dict"""

    print(f"Processing {scr_path.as_posix()}")

    # parse scr
    parsed = list(parse_scr_gen(scr_path))

    # entry for use as model idx lookup table in godot
    model_entries = {
        name: {"idx": idx, "file": dtm} for idx, name, _, dtm in parsed
    }

    # entry for scaling lookup table in blender
    scale_entries = {
        dtm[0]: scale[0] for idx, name, scale, dtm in parsed
    }

    return model_entries, scale_entries


def main(args):
    # fetch subdir
    dtm_dir = args.base_t_dir / "Model"
    model_scr = args.base_t_dir / "Script" / "model.scr"

    # parse scr & save model index
    model_lookup, scale_lookup = process_model_scr(model_scr)
    OUTPUT_LOOKUP.write_text(json.dumps(model_lookup, indent=2), "utf8")

    path_list = []

    # parse each dtm file
    for file in dtm_dir.iterdir():

        # just in case
        if file.suffix != ".dtm":
            continue

        # process & add scale info
        output = process_dtm(file)
        try:
            output["scale"] = scale_lookup[file.name]
        except KeyError:
            # this model is dummy data!
            print(f"! Ignoring dummy data {file.name}")
            continue

        # save, but not using indent as file gets hard to read as each 3-digit coordinate takes one line.
        out_file = OUTPUT / f"{file.stem}.json"
        out_file.write_text(json.dumps(output), "utf8")
        path_list.append(out_file.as_posix())

    # write converted DTM entries, so it could be loaded in blender easily
    OUTPUT_LIST.write_text("\n".join(path_list), "utf8")


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
        else:
            # we can't proceed, show usage instead
            _parser.print_usage()
            exit()

    main(_args)
