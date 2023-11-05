import pathlib
import json
import re

WRITE_ENCODING = "utf8"

ROOT = pathlib.Path(__file__).parent
CSV = ROOT / "terrain_info.csv"
JSON = ROOT / "terrain_info.json"

PATTERN = re.compile(r"\[(\S* \S*)]")


def parse_area(line: str) -> list:
    if not line:
        return [[0, 0]]

    return [
        list(map(int, part.split())) for part in PATTERN.findall(line)
    ]


def convert():
    # too simple for using csv module, go raw
    raw = CSV.read_text()

    data = {}

    for line in raw.splitlines():
        if not line.strip():
            continue

        name, passable, area, _ = line.split(',')

        data[name] = parse_area(area) if passable == "F" else []

    JSON.write_text(json.dumps(data), WRITE_ENCODING)


if __name__ == '__main__':
    convert()
