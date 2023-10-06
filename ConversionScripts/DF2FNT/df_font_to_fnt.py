"""
Script to convert Armada Tank's DF font format to bitmap fnt.

Requires df_fonts dir next to script. With structure of:

df_fonts
├ 128
│   ├ FontAdv_FD_128.df
│   ├ FontAdv_FD_128.png
│
├ 224
│   ├ FontAdv_FD_224.df
│   ├ FontAdv_FD_224.png
│   ├ FontAdv_FD_224_B.png
│   ├ FontAdv_FD_224_R.png
│   ├ FontAdv_FD_224_Y.png
│
├ 256
│   ├ FontAdv_FD.df
│   ├ FontAdv_FD.png
│   ├ FontAdv_FD_B.png
│   ├ FontAdv_FD_R.png


Initially separated each char with manually drawn borders and my script `ImageFontSplitter`.
Then used Angelcode's awesome BMfont generator tool.

However, it was incredibly frustrating to input file one by one, and I have hundreds of it!

After making one and thinking of doing that 3 times more - I just decided to make converter instead.

This following script is trying to mimic what's produced in BMFont gen.

: jupiterbjy@gmail.com
"""

import pathlib
import shutil
from os import PathLike
from typing import Sequence, Iterator, Tuple

from PIL import Image, ImageDraw

# Configurations ----------------------------

# encoding for reading DF font file
FILE_ENCODING = "utf8"

# mapping in (Range in DF Lit):(Range in BMP) pairs
BMP_MAPPING = {
    (32, 127): ("latin", 32, 126),
    (128, 175): ("cyrillic", 1040, 1087),
    (176, 223): ("latin-1", 192, 239),
    (224, 239): ("cyrillic", 1088, 1103),
    (240, 255): ("latin-1", 240, 255),
}

# border color for each TypeFaces.
BORDER_COLOR = {
    "unused": (255, 0, 0, 255),
    "latin": (0, 255, 0, 255),
    "latin-1": (0, 255, 0, 255),
    "cyrillic": (0, 0, 255, 255),
}

# refer http://www.angelcode.com/products/bmfont/doc/file_format.html for configuring header.
# need to strip proceeding newline. One at tail is fine.
HEADER_FORMAT = """
info face="Arial" size={} bold=0 italic=0 charset="" unicode=1 stretchH=100 smooth=0 aa=1 padding=0,0,0,0 spacing=2,2 outline=0
common lineHeight={} base={} scaleW=256 scaleH=512 pages=1 packed=0 alphaChnl=0 redChnl=0 greenChnl=0 blueChnl=0
page id=0 file="{}"
chars count={}
"""
# need to fill size, lineHeight, base, file, count when formatting

# each char line format. Need to strip proceeding newline. One at tail is fine.
LINE_FORMAT = """
char id={}  x={}  y={}  width={}  height={}  xoffset=0  yoffset=0  xadvance={}  page=0  chnl=15
"""

# numer of char for each value, so line vertically aligns.
LINE_VALUE_PAD = 5

# -------------------------------------------


ROOT = pathlib.Path(__file__).parent
DF_PATH = ROOT / "df_fonts"
OUTPUT_PATH = ROOT / "output"
OUTPUT_PATH.mkdir(exist_ok=True)


def parse_lit(line_iter: Iterator[str], x_offset) -> Tuple[int, int, int, int]:
    """Parse line and yield coordination pairs (x_left, y_top, x_right, y_bottom)"""
    for line in line_iter:
        line = line.removeprefix("Lit ")
        idx, x_l, x_r, y_top, y_bot, w, h = map(int, line.split())

        yield x_l - x_offset, y_top, x_r, y_bot


def parse_value(line_iter: Iterator[str]):
    for line in line_iter:
        yield line.split(" ")[-1]


class DFFont:
    def __init__(self, font_path: PathLike):
        font_path = pathlib.Path(font_path)

        self.font_name = font_path.stem

        self.version = 0
        self.active = 1
        self.num_lit = 0
        self.add_x = 0
        self.img_size = (0, 0)
        self.lit_list = []

        self.parse_df(font_path)

    def parse_df(self, file_path):
        data = file_path.read_text(FILE_ENCODING).splitlines()
        data_iter = (line for line in data if line)
        header_parser = parse_value(data_iter)

        self.version = next(header_parser)

        # probably number of images used in font?
        self.active = int(next(header_parser))

        # number of character areas
        self.num_lit = int(next(header_parser))

        # AddX param probably is offsetting param
        self.add_x = int(next(header_parser))

        # img size
        self.img_size = int(next(header_parser)), int(next(header_parser))

        # lit data - font itself. (idx, x_left, x_right, y_top, y_bottom, width, height)
        # too lazy to validate lit count
        self.lit_list.extend(parse_lit(data_iter, self.add_x))

    def __iter__(self):
        return iter(self.lit_list)


def translate_df_idx(df_idx):
    """Returns face_id and bmp idx"""
    for (df_start, df_end), (face, bmp_start, bmp_end) in BMP_MAPPING.items():
        if df_start <= df_idx <= df_end:
            return face, df_idx + bmp_start - df_start

    return "unused", df_idx


def draw_df_outline(img_path: pathlib.Path, parsed: DFFont):
    img = Image.open(img_path)
    draw = ImageDraw.Draw(img)

    for idx, coordinate in enumerate(parsed):
        face, bmp_idx = translate_df_idx(idx)
        draw.rectangle(coordinate, outline=BORDER_COLOR[face])

    # img.show()
    return img


def generate_fnt_gen(font: DFFont, img_paths: Sequence[pathlib.Path]):
    lines = []

    # build char lines
    for idx, coordinate in enumerate(font):
        face, bmp_idx = translate_df_idx(idx)
        if face == "unused":
            continue

        x_l, y_t, x_r, y_b = coordinate

        # offset each by 1, it's padding area
        x_l += 1
        y_t += 1
        x_r -= 1
        y_b -= 1

        width = x_r - x_l + 1
        height = y_b - y_t + 1

        size_padded = (
            f"{val:<{LINE_VALUE_PAD}}" for val in (bmp_idx, x_l, y_t, width, height, width)
        )

        lines.append(
            LINE_FORMAT.format(*size_padded).lstrip("\n")
        )

    line_joined = "".join(lines)

    # build header
    # noinspection PyUnboundLocalVariable
    base = int(height * 0.75)

    headers = [
        HEADER_FORMAT.format(height, height, base, img_path.name, len(lines)).lstrip("\n")
        for img_path in img_paths
    ]

    # combine & yield
    for header in headers:
        yield header + line_joined


def main():
    for subdir in DF_PATH.iterdir():

        if not subdir.is_dir():
            continue

        images = [p for p in subdir.iterdir() if p.suffix == ".png"]
        font = [p for p in subdir.iterdir() if p.suffix == ".df"][0]

        parsed = DFFont(font)

        print(f"Parsed {parsed.font_name}")

        # generate and show preview of grids
        bordered = draw_df_outline(images[0], parsed)

        # save as new file if not saved already, cause why not! looks cool ain't it?
        bordered_img_path = OUTPUT_PATH / f"{font.stem}_bordered.png"

        if not bordered_img_path.exists():
            print("No reference image found, saving one")

            bordered.save(bordered_img_path)

        # generate font & copy img
        for raw_text, img_path in zip(generate_fnt_gen(parsed, images), images):

            # create subdir
            tgt_subdir = OUTPUT_PATH / img_path.stem
            tgt = tgt_subdir / f"{img_path.stem}.fnt"
            tgt_subdir.mkdir(exist_ok=True)

            print(f"Saving {tgt}")

            tgt.write_text(raw_text, FILE_ENCODING)
            shutil.copy(img_path, tgt_subdir / img_path.name)


if __name__ == '__main__':
    main()
