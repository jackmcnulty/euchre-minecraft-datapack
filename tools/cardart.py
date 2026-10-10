"""Pixel-art playing cards for the Euchre resource pack, standard library only.

Every texture is drawn from the small bitmaps below and encoded as PNG with
zlib, so the art is reproducible byte-for-byte and needs no image library.
tools/gen.py writes the results into the resource pack and checks them in CI
like any other generated file.

Textures are 32x32 (a card 22 px wide and 30 px tall, centred), rendered by
Minecraft's item/generated model like any item sprite.
"""

from __future__ import annotations

import struct
import zlib

Pixel = tuple[int, int, int, int]
Image = list[list[Pixel]]

SIZE = 32
CLEAR: Pixel = (0, 0, 0, 0)
PAPER: Pixel = (250, 248, 240, 255)
FACE_PAPER: Pixel = (252, 243, 214, 255)
EDGE: Pixel = (60, 60, 70, 255)
RED: Pixel = (200, 40, 40, 255)
BLACK: Pixel = (30, 30, 36, 255)
GOLD: Pixel = (214, 160, 40, 255)
BACK: Pixel = (36, 64, 150, 255)
BACK_LIGHT: Pixel = (88, 124, 214, 255)
FELT: Pixel = (31, 92, 58, 255)

# Card body inside the 32x32 sprite.
X0, Y0, X1, Y1 = 5, 1, 26, 30  # inclusive

# 3x5 rank glyphs.
GLYPHS = {
    "9": ["###", "#.#", "###", "..#", "###"],
    "1": [".#.", "##.", ".#.", ".#.", "###"],
    "0": ["###", "#.#", "#.#", "#.#", "###"],
    "J": ["..#", "..#", "..#", "#.#", "###"],
    "Q": ["###", "#.#", "#.#", "###", "..#"],
    "K": ["#.#", "##.", "#..", "##.", "#.#"],
    "A": [".#.", "#.#", "###", "#.#", "#.#"],
}

# 5x5 corner pips and 9x9 centre pips, per suit key.
SMALL_PIPS = {
    "clubs": [".###.", "#####", "#####", "..#..", ".###."],
    "spades": ["..#..", ".###.", "#####", "..#..", ".###."],
    "diamonds": ["..#..", ".###.", "#####", ".###.", "..#.."],
    "hearts": ["##.##", "#####", "#####", ".###.", "..#.."],
}
BIG_PIPS = {
    "clubs": ["...###...", "..#####..", "..#####..", ".#.###.#.", "#########",
              "#########", ".##.#.##.", "....#....", "...###..."],
    "spades": ["....#....", "...###...", "..#####..", ".#######.", "#########",
               "#########", ".##.#.##.", "....#....", "...###..."],
    "diamonds": ["....#....", "...###...", "..#####..", ".#######.", "#########",
                 ".#######.", "..#####..", "...###...", "....#...."],
    "hearts": [".##...##.", "####.####", "#########", "#########", ".#######.",
               "..#####..", "...###...", "....#....", "........."],
}


def blank(w: int = SIZE, h: int = SIZE, fill: Pixel = CLEAR) -> Image:
    return [[fill for _ in range(w)] for _ in range(h)]


def stamp(img: Image, bitmap: list[str], x: int, y: int, color: Pixel, flip: bool = False) -> None:
    """Draw a bitmap ('#' = ink) with its top-left at (x, y); flip rotates it 180°."""
    rows = [r[::-1] for r in reversed(bitmap)] if flip else bitmap
    for dy, row in enumerate(rows):
        for dx, ch in enumerate(row):
            if ch == "#":
                img[y + dy][x + dx] = color


def card_body(img: Image, fill: Pixel) -> None:
    """Rounded rectangle with a 1 px border."""
    for y in range(Y0, Y1 + 1):
        for x in range(X0, X1 + 1):
            corner = (x in (X0, X1)) and (y in (Y0, Y1))
            if corner:
                continue
            edge = x in (X0, X1) or y in (Y0, Y1)
            img[y][x] = EDGE if edge else fill


def rank_bitmap(rank: str) -> list[str]:
    """'10' is two glyphs side by side, one pixel apart."""
    parts = [GLYPHS[c] for c in rank]
    return [".".join(p[r] for p in parts) for r in range(5)]


def card_face(rank: str, suit_key: str, red: bool) -> Image:
    ink = RED if red else BLACK
    face = rank in ("J", "Q", "K")
    img = blank()
    card_body(img, FACE_PAPER if face else PAPER)

    rb = rank_bitmap(rank)
    width = len(rb[0])
    # Top band: rank at the left, a small pip at the right (rows 3-7). The
    # bottom band repeats both rotated 180°, like a real card (rows 24-28).
    # The middle (rows 9-21) is left for the large pip.
    stamp(img, rb, X0 + 2, Y0 + 2, ink)
    stamp(img, SMALL_PIPS[suit_key], X1 - 6, Y0 + 2, ink)
    stamp(img, rb, X1 - 1 - width, Y1 - 6, ink, flip=True)
    stamp(img, SMALL_PIPS[suit_key], X0 + 2, Y1 - 6, ink, flip=True)

    # Centre: a large pip; court cards get a gold frame around it.
    cx, cy = X0 + (X1 - X0) // 2 - 4, Y0 + (Y1 - Y0) // 2 - 4
    if face:
        for x in range(cx - 2, cx + 11):
            img[cy - 2][x] = GOLD
            img[cy + 10][x] = GOLD
        for y in range(cy - 2, cy + 11):
            img[y][cx - 2] = GOLD
            img[y][cx + 10] = GOLD
    stamp(img, BIG_PIPS[suit_key], cx, cy, ink)
    return img


def card_back() -> Image:
    img = blank()
    card_body(img, PAPER)
    for y in range(Y0 + 2, Y1 - 1):
        for x in range(X0 + 2, X1 - 1):
            lattice = (x + y) % 4 == 0 or (x - y) % 4 == 0
            img[y][x] = BACK_LIGHT if lattice else BACK
    return img


def scale(img: Image, k: int) -> Image:
    return [[px for px in row for _ in range(k)] for row in img for _ in range(k)]


def paste(dst: Image, src: Image, x: int, y: int) -> None:
    for dy, row in enumerate(src):
        for dx, px in enumerate(row):
            if px[3]:
                dst[y + dy][x + dx] = px


def pack_icon(ace_of_spades: Image) -> Image:
    """64x64 pack.png: the ace of spades on felt."""
    img = blank(64, 64, FELT)
    paste(img, scale(ace_of_spades, 2), 0, 0)
    return img


def preview_sheet(faces: list[Image], back: Image, per_row: int = 6, k: int = 3) -> Image:
    """All cards in a grid on felt, plus the back, for the README."""
    cell = SIZE * k
    rows = (len(faces) + per_row - 1) // per_row
    w, h = cell * (per_row + 1) + 8, cell * rows + 8
    img = blank(w, h, FELT)
    for i, face in enumerate(faces):
        paste(img, scale(face, k), 4 + (i % per_row) * cell, 4 + (i // per_row) * cell)
    paste(img, scale(back, k), 4 + per_row * cell, 4)
    return img


def to_png(img: Image) -> bytes:
    """Encode RGBA rows as a PNG (deterministic: fixed filter and compression)."""
    h, w = len(img), len(img[0])
    raw = b"".join(b"\x00" + bytes(c for px in row for c in px) for row in img)

    def chunk(kind: bytes, data: bytes) -> bytes:
        return (struct.pack(">I", len(data)) + kind + data
                + struct.pack(">I", zlib.crc32(kind + data) & 0xFFFFFFFF))

    header = struct.pack(">IIBBBBB", w, h, 8, 6, 0, 0, 0)  # 8-bit RGBA
    return (b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", header)
            + chunk(b"IDAT", zlib.compress(raw, 9)) + chunk(b"IEND", b""))
