#!/usr/bin/env python3
"""Point Formula/landin.rb at a Landin release.

Usage: bump-landin.py [VERSION]   (default: the latest release)

Reads each archive's published .sha256 file, so nothing is downloaded but
those. Prints the new version when the formula changed, nothing otherwise.
"""
import json
import pathlib
import re
import sys
import urllib.request

REPO = "701-dev/Landin"
FORMULA = pathlib.Path(__file__).resolve().parent.parent / "Formula" / "landin.rb"
PLATFORMS = ("aarch64-darwin", "aarch64-linux", "x86_64-linux")


def fetch(url):
    with urllib.request.urlopen(url, timeout=60) as response:
        return response.read().decode()


def main():
    if len(sys.argv) > 1:
        new = sys.argv[1].removeprefix("v")
    else:
        latest = json.loads(fetch(f"https://api.github.com/repos/{REPO}/releases/latest"))
        new = latest["tag_name"].removeprefix("v")
    if not re.fullmatch(r"[0-9]+(\.[0-9]+)*", new):
        sys.exit(f"not a release version: {new}")

    text = FORMULA.read_text()
    old = re.search(r"/releases/download/v([0-9.]+)/", text).group(1)
    text = text.replace(f"v{old}/", f"v{new}/").replace(f"landin-{old}-", f"landin-{new}-")
    for platform in PLATFORMS:
        name = f"landin-{new}-{platform}.tar.gz"
        base = f"https://github.com/{REPO}/releases/download/v{new}/{name}"
        digest = fetch(base + ".sha256").split()[0]
        if not re.fullmatch(r"[0-9a-f]{64}", digest):
            sys.exit(f"{name}.sha256 does not start with a SHA-256 sum")
        pattern = re.compile(r'(url "' + re.escape(base) + r'"\n\s+sha256 ")[0-9a-f]{64}"')
        text, count = pattern.subn(lambda m: m.group(1) + digest + '"', text)
        if count != 1:
            sys.exit(f"the formula has no url line for {name}")
    if text != FORMULA.read_text():
        FORMULA.write_text(text)
        print(new)


if __name__ == "__main__":
    main()
