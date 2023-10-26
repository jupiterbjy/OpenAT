"""
Simple script for searching contents in each map files to aid reverse-engineering.

Originally was defining search function in ptpython everytime, decided to make this into a script.
"""

import pathlib
import itertools


DEFAULT_PATH = pathlib.Path(r"C:\Program Files (x86)\Armada Tanks\BaseT")
WRITE_ENCODING = "utf8"
READ_ENCODING = "windows 1251"


DIRS = DEFAULT_PATH / "Map"
FILES = list(itertools.chain(*(p.iterdir() for p in DIRS.iterdir() if p.is_dir())))


def safe_read(path: pathlib.Path) -> str:
    try:
        return path.read_text()

    except UnicodeDecodeError:
        # SAND/m5.map has letter ‘ in file, which requires windows-1251

        print(f"System default failed, using {READ_ENCODING} instead.")
        return path.read_text(READ_ENCODING)


def search(keyword: str):
    for file in FILES:
        for line_no, line in enumerate(safe_read(file).splitlines(), 1):
            if keyword in line:
                print(f"{file.as_posix()}\n[{line_no}] {line}\n")
                break
        else:
            # couldn't find any
            print(f"{file.as_posix()}\nNo match\n")

    print("End of search results\n")


if __name__ == '__main__':
    while (_keyword := input("Keyword (Q to exit) > ")) not in "Qq":
        search(_keyword)
