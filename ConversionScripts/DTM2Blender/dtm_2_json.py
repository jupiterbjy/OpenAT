"""
Converts dmt format into common json format. Drag n drop directory containing *.dtm files on this script!

: jupiterbjy@gmail.com
"""

import pathlib
import json
from pprint import pprint

from argparse import ArgumentParser
from itertools import chain
from typing import Iterator, Sequence


COMMON_KEYWORDS = {"Face", "TVertex", "TextureFaces", "Vertex", "TFace"}
ROOT = pathlib.Path(__file__).parent

OUTPUT = ROOT / "dtm2json_output"
OUTPUT.mkdir(exist_ok=True)
OUTPUT_LIST = OUTPUT / "_files.txt"


def count_indent(line: str):
    combo = 0
    for char in line:
        if char == " ":
            combo += 1
        else:
            return combo


def recover_type(val: str):
    # is int? there's no neg int in file, this is fine
    if val.isdigit():
        return int(val)

    # is it float? in this file, just period check is enough
    if "." in val:
        return float(val)

    # else just string, our time wasted!
    return val


def parse_dict(string_iter: Iterator):
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
            child_key, child_val = parse_dict(chain((line,), string_iter))
        else:
            child_key, *child_val = map(recover_type, line.strip().split())

            # if key is among these, set next first level in child as key.
            # totally fine to do so as these lines start with [type] [idx] [values].
            if child_key in COMMON_KEYWORDS:
                child_key, *child_val = child_val

            # for each value,

        # add to dict, but store only a value if it's single value
        if isinstance(child_val, Sequence) and len(child_val) == 1:
            val[child_key] = child_val[0]
        else:
            val[child_key] = child_val


def main(args):
    path_list = []

    for file in args.dtm_dir.iterdir():
        if file.suffix != ".dtm":
            continue

        print(f"Processing {file}")
        _, parsed = parse_dict(iter(file.read_text().splitlines()))

        # reconstruct to our taste
        # since python 3.7 dict retain insertion order. no need to consider loosing index keys.
        output = {
            "vertices": [*parsed["Frame 0"]["Vertices"].values()],
            "faces": [(v1, v2, v3) for v1, v2, v3, _, _, in parsed["Faces"].values()],
            "tex_vert": [*parsed["MapChannel 1"]["TextureVertices"].values()],
            "tex_loop": [*parsed["MapChannel 1"]["TextureFaces"].values()],
        }

        pprint(output)

        # save, but not using indent as file gets hard to read as each 3-digit coordinate takes one line.
        out_file = OUTPUT / f"{file.stem}.json"
        out_file.write_text(json.dumps(output), "utf8")
        path_list.append(out_file.as_posix())

    OUTPUT_LIST.write_text("\n".join(path_list), "utf8")


if __name__ == '__main__':
    _parser = ArgumentParser()
    _parser.add_argument(
        "dtm_dir",
        metavar="F",
        type=pathlib.Path,
        help="Directory path containing DTM files"
    )

    _args = _parser.parse_args()
    main(_args)
