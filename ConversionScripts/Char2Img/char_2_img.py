"""
A simple script to convert text-notated walls into visual image to aid recreation process
"""

from argparse import ArgumentParser
import pathlib
from typing import Iterator, Tuple, List, Sequence

from PIL import Image, ImageDraw


BLOCK_SIZE = 10
COLOR_MAPPING = {
    " ": (0, 0, 0, 0),
    "0": (255, 0, 0, 255),
    "2": (255, 0, 0, 255),
    "4": (255, 0, 0, 255),
    "#": (255, 0, 0, 255),
    "9": (0, 255, 0, 255),
    "7": (0, 255, 0, 255),
    "5": (0, 255, 0, 255),
    "&": (0, 255, 0, 255),
    "%": (100, 100, 100, 255),
}


def get_size(line_iter: Iterator) -> Tuple[int, int]:
    for line in line_iter:
        if "size" in line:
            _, w, h = line.split()
            return int(w), int(h)


def get_wall_layout(line_iter: Iterator) -> List[str]:
    for line in line_iter:
        if "wall" in line:
            break

    lines = []
    while "endwall" not in (line := next(line_iter)):
        lines.append(line.removeprefix("  ln \"").removesuffix("\" "))

    return lines


def draw_blocks(img_draw: ImageDraw.ImageDraw, lines: Sequence[str]):

    for y, line in enumerate(lines):
        y *= BLOCK_SIZE

        for x, char in enumerate(line):
            x *= BLOCK_SIZE

            color = COLOR_MAPPING[char]
            img_draw.rectangle((x, y, x + BLOCK_SIZE, y + BLOCK_SIZE), color, color)


def main(args):
    for map_path in args.map_file:
        iterator = (line for line in map_path.read_text().splitlines())

        w, h = get_size(iterator)
        lines = get_wall_layout(iterator)

        # prep image
        img = Image.new("RGBA", (2 * w * BLOCK_SIZE, 2 * h * BLOCK_SIZE))
        img_draw = ImageDraw.Draw(img)

        # draw
        draw_blocks(img_draw, lines)

        # save
        save_path = map_path.with_suffix(".png")
        img.save(save_path)


if __name__ == '__main__':
    _parser = ArgumentParser()
    _parser.add_argument(
        "map_file",
        metavar="F",
        nargs="+",
        type=pathlib.Path,
        help=".map files"
    )

    main(_parser.parse_args())
