"""Pixel-art playing cards for the Euchre resource pack, standard library only.

Every texture is drawn from the small bitmaps below and encoded as PNG with
zlib, so the art is reproducible and needs no image library. tools/gen.py
writes the results into the resource pack and checks them in CI like any other
generated file.

Design: "big index" cards, built for legibility rather than realism. A hotbar
slot draws an item at 16x16 GUI pixels, i.e. half the texture's resolution at
GUI scale 1, so the face is almost entirely a LARGE rank (top half) and a LARGE
suit pip (bottom half), drawn with 2 px strokes (base glyphs scaled 2x), with
only a thin rounded border. Textures are 32x32 and use the full height.
"""

from __future__ import annotations

import struct
import zlib

Pixel = tuple[int, int, int, int]
Image = list[list[Pixel]]

SIZE = 32
CLEAR: Pixel = (0, 0, 0, 0)
PAPER: Pixel = (255, 255, 255, 255)
COURT_PAPER: Pixel = (255, 246, 214, 255)  # light tint for J/Q/K
EDGE: Pixel = (70, 70, 80, 255)
RED: Pixel = (214, 24, 32, 255)
BLACK: Pixel = (18, 18, 22, 255)
BACK: Pixel = (36, 64, 150, 255)
BACK_LIGHT: Pixel = (88, 124, 214, 255)
FELT: Pixel = (31, 92, 58, 255)
SLOT: Pixel = (139, 139, 139, 255)       # hotbar slot grey (preview only)
SLOT_EDGE: Pixel = (55, 55, 55, 255)

# Card body inside the 32x32 sprite (inclusive): 24 wide, the full 32 tall.
X0, Y0, X1, Y1 = 4, 0, 27, 31

# Base glyphs (5x7; "1" is 3x7 so "10" fits), drawn at 2x => 10x14 px, 2 px strokes.
GLYPHS = {
    "9": [".###.", "#...#", "#...#", ".####", "....#", "...#.", ".##.."],
    "1": [".#.", "##.", ".#.", ".#.", ".#.", ".#.", "###"],
    "0": [".###.", "#...#", "#...#", "#...#", "#...#", "#...#", ".###."],
    "J": ["..###", "...#.", "...#.", "...#.", "#..#.", "#..#.", ".##.."],
    "Q": [".###.", "#...#", "#...#", "#...#", "#.#.#", "#..#.", ".##.#"],
    "K": ["#...#", "#..#.", "#.#..", "##...", "#.#..", "#..#.", "#...#"],
    "A": [".###.", "#...#", "#...#", "#####", "#...#", "#...#", "#...#"],
}

# Base suit pips (7x7), drawn at 2x => 14x14 px.
PIPS = {
    "clubs": ["..###..", "..###..", "#.###.#", "#######", "#.###.#", "...#...", "..###.."],
    "spades": ["...#...", "..###..", ".#####.", "#######", "#######", "...#...", "..###.."],
    "diamonds": ["...#...", "..###..", ".#####.", "#######", ".#####.", "..###..", "...#..."],
    "hearts": [".##.##.", "#######", "#######", "#######", ".#####.", "..###..", "...#..."],
}
SCALE = 2


def blank(w: int = SIZE, h: int = SIZE, fill: Pixel = CLEAR) -> Image:
    return [[fill for _ in range(w)] for _ in range(h)]


def stamp(img: Image, bitmap: list[str], x: int, y: int, color: Pixel, k: int = 1) -> None:
    """Draw a bitmap ('#' = ink) with its top-left at (x, y), each cell k x k px."""
    for dy, row in enumerate(bitmap):
        for dx, ch in enumerate(row):
            if ch == "#":
                for yy in range(k):
                    for xx in range(k):
                        img[y + dy * k + yy][x + dx * k + xx] = color


def card_body(img: Image, fill: Pixel) -> None:
    """Rectangle with a 1 px border and rounded (cut) corners."""
    for y in range(Y0, Y1 + 1):
        for x in range(X0, X1 + 1):
            if (x in (X0, X1)) and (y in (Y0, Y1)):
                continue
            edge = x in (X0, X1) or y in (Y0, Y1)
            img[y][x] = EDGE if edge else fill


def rank_bitmap(rank: str) -> list[str]:
    """'10' is two glyphs side by side, one cell apart."""
    parts = [GLYPHS[c] for c in rank]
    return [".".join(p[r] for p in parts) for r in range(7)]


def centred_x(width_px: int) -> int:
    return X0 + ((X1 - X0 + 1) - width_px) // 2


def card_face(rank: str, suit_key: str, red: bool) -> Image:
    ink = RED if red else BLACK
    img = blank()
    card_body(img, COURT_PAPER if rank in ("J", "Q", "K") else PAPER)
    # Rank: rows 2-15 (14 px). Suit: rows 17-30 (14 px).
    rb = rank_bitmap(rank)
    stamp(img, rb, centred_x(len(rb[0]) * SCALE), 2, ink, SCALE)
    pip = PIPS[suit_key]
    stamp(img, pip, centred_x(len(pip[0]) * SCALE), 17, ink, SCALE)
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


def resample(img: Image, size: int) -> Image:
    """Nearest-neighbour resize to size x size, like the GUI draws a 32 px
    texture into a 16 px slot (no smoothing)."""
    n = len(img)
    return [[img[y * n // size][x * n // size] for x in range(size)] for y in range(size)]


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


def hotbar_strip(cards: list[Image], slot: int) -> Image:
    """Cards drawn at their real on-screen size in hotbar-like slots: `slot` px
    per card (16 = GUI scale 1, 32 = GUI scale 2, 48 = GUI scale 3)."""
    pad = max(1, slot // 8)
    cell = slot + 2 * pad
    img = blank(cell * len(cards), cell, SLOT_EDGE)
    for i, card in enumerate(cards):
        for y in range(1, cell - 1):
            for x in range(1, cell - 1):
                img[y][i * cell + x] = SLOT
        paste(img, resample(card, slot), i * cell + pad, pad)
    return img


def preview_sheet(faces: list[Image], back: Image, per_row: int = 6, k: int = 3) -> Image:
    """All cards enlarged in a grid on felt, plus the back; below that, every
    card at real hotbar size for GUI scales 1, 2 and 3, to judge legibility at
    the size players actually see."""
    cell = SIZE * k
    rows = (len(faces) + per_row - 1) // per_row
    strips = [hotbar_strip(faces[i:i + 12], s) for s in (16, 32, 48) for i in (0, 12)]
    strips_h = sum(len(s) + 6 for s in strips)
    w = max(cell * (per_row + 1) + 8, max(len(s[0]) for s in strips) + 8)
    h = cell * rows + 8 + strips_h + 4
    img = blank(w, h, FELT)
    for i, face in enumerate(faces):
        paste(img, scale(face, k), 4 + (i % per_row) * cell, 4 + (i // per_row) * cell)
    paste(img, scale(back, k), 4 + per_row * cell, 4)
    y = cell * rows + 12
    for s in strips:
        paste(img, s, 4, y)
        y += len(s) + 6
    return img


def to_png(img: Image) -> bytes:
    """Encode RGBA rows as a PNG (fixed filter and compression level)."""
    h, w = len(img), len(img[0])
    raw = b"".join(b"\x00" + bytes(c for px in row for c in px) for row in img)

    def chunk(kind: bytes, data: bytes) -> bytes:
        return (struct.pack(">I", len(data)) + kind + data
                + struct.pack(">I", zlib.crc32(kind + data) & 0xFFFFFFFF))

    header = struct.pack(">IIBBBBB", w, h, 8, 6, 0, 0, 0)  # 8-bit RGBA
    return (b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", header)
            + chunk(b"IDAT", zlib.compress(raw, 9)) + chunk(b"IEND", b""))
