"""
Script for Splitting font image used in Armada Tanks.

jupiterbjy@gmail.com
"""

import pathlib
from typing import Tuple, List

from PIL import Image


EXTENSION = ".png"

START_COLOR = (0, 255, 0, 255)
BOUNDARY_COLOR = (255, 0, 0, 255)
END_COLOR = (0, 0, 255, 255)


ROOT = pathlib.Path(__file__).parent

MASK = ROOT / "mask" / "mask.png"
IMG_DIR = ROOT / "font_images"
OUT_DIR = ROOT / "output"

IMG_DIR.mkdir(exist_ok=True)
OUT_DIR.mkdir(exist_ok=True)


def find_start_pos(start_x, start_y, img: Image.Image) -> Tuple[int, int]:
    """Returns letter area start position in pixel(x, y)"""

    img_w, img_h = img.size

    # would be better using numpy array but out of time rn
    for y in range(start_y, img_h):
        for x in range(start_x, img_w):
            if img.getpixel((x, y)) == START_COLOR:
                return x + 1, y
        else:
            # failed to find in this row, reset start
            start_x = 0
    else:
        # failed to return, end of image
        raise IndexError


def get_letter_size(start_x, start_y, img: Image.Image) -> Tuple[int, int, bool]:
    """Returns letter area width and height, and if there's more letter behind"""

    height = 0
    width = 0

    img_w, img_h = img.size
    continue_flag = True

    for x in range(start_x, img_w):
        pixel = img.getpixel((x, start_y))
        if pixel == BOUNDARY_COLOR:
            break

        if pixel == END_COLOR:
            continue_flag = False
            break

        width += 1

    for y in range(start_y, img_h):
        if img.getpixel((start_x, y)) == BOUNDARY_COLOR:
            break

        height += 1

    return width, height, continue_flag


def fetch_letter_area(img: Image.Image):
    """Fetch letters"""

    cur_x = 0
    cur_y = 0

    # keeps (left, top, right, bottom) pixel coord tuples
    letter_area: List[Tuple[int, int, int, int]] = []

    while True:
        try:
            cur_x, cur_y = find_start_pos(cur_x, cur_y, img)
        except IndexError:
            print("End of image reached, breaking")
            break

        while True:
            letter_w, letter_h, is_letter_trailing = get_letter_size(cur_x, cur_y, img)

            # do not subtract 1 from bottom/right, pillow always cut 1 pixel shorter
            letter_area.append((cur_x, cur_y, cur_x + letter_w, cur_y + letter_h))

            cur_x += letter_w + 1
            if not is_letter_trailing:
                # well if I make here like this then there's no point of other part not being hard-coded..
                cur_y += letter_h
                break

    return letter_area


def main():
    areas = fetch_letter_area(Image.open(MASK).convert())
    area_digit_count = len(str(len(areas)))

    images = [path for path in IMG_DIR.iterdir() if path.suffix == EXTENSION]

    for path in images:
        # create subdir with image's name
        subdir = OUT_DIR / path.stem
        subdir.mkdir(exist_ok=True)

        img: Image.Image = Image.open(path)

        for idx, area in enumerate(areas):
            cropped = img.crop(area)
            img_path = subdir / f"{idx:0{area_digit_count}}{EXTENSION}"

            print("Saving image", img_path)
            cropped.save(img_path)


if __name__ == '__main__':
    main()
