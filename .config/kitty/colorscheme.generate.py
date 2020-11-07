#!/usr/bin/env python

import sys
import re


COLORSCHEMES = {
    "dark": {
        "theme": "solarized",
        "palette": "solarized",
        "cursor_text_color": "{base02}",
        "cursor": "{base0}",
        "foreground": "{base0}",
        "background": "{base03}",
        "selection_foreground": "{base1}",
        "selection_background": "{base02}",
    },
    "light": {
        "theme": "solarized",
        "palette": "solarized",
        "cursor_text_color": "{base2}",
        "cursor": "{base00}",
        "foreground": "{base00}",
        "background": "{base3}",
        "selection_foreground": "{base01}",
        "selection_background": "{base2}",
    },
    "greyscale-dark": {
        "theme": "solarized",
        "palette": "solarized-greyscale",
        "cursor_text_color": "{base02}",
        "cursor": "{base0}",
        "foreground": "{base0}",
        "background": "{base03}",
        "selection_foreground": "{base1}",
        "selection_background": "{base02}",
    },
    "greyscale-light": {
        "theme": "solarized",
        "palette": "solarized-greyscale",
        "cursor_text_color": "{base2}",
        "cursor": "{base00}",
        "foreground": "{base00}",
        "background": "{base3}",
        "selection_foreground": "{base01}",
        "selection_background": "{base2}",
    },
}

THEMES = {
    "solarized": {
        "color0": "{base02}",
        "color1": "{red}",
        "color2": "{green}",
        "color3": "{yellow}",
        "color4": "{blue}",
        "color5": "{magenta}",
        "color6": "{cyan}",
        "color7": "{base2}",
        "color8": "{base03}",
        "color9": "{orange}",
        "color10": "{base01}",
        "color11": "{base00}",
        "color12": "{base0}",
        "color13": "{violet}",
        "color14": "{base1}",
        "color15": "{base3}",
    },
}

TABLE_HEADER = """
" SOLARIZED HEX     16/8 TERMCOL  XTERM/HEX   L*A*B      sRGB        HSB
" --------- ------- ---- -------  ----------- ---------- ----------- -----------
""".strip().split(
    "\n"
)


def read_table(f):
    match_window = []
    # Read until we find the table header
    for line in f:
        line = line.strip()
        match_window.append(line)
        if len(match_window) <= len(TABLE_HEADER):
            continue
        match_window.pop(0)
        if match_window == TABLE_HEADER:
            break
    # Read table
    for line in f:
        parts = [p for p in re.split("[ \"']+", line) if len(p) > 0]
        if len(parts) < 3:
            break
        yield (parts[0], parts[1])


def read_palette(filename):
    palette = {}
    with open(filename, "r") as f:
        for name, value in read_table(f):
            palette[name] = value
    return palette


PALETTES = {
    "solarized": read_palette("../../.config/nvim/colors/solarized.vim"),
    "solarized-greyscale": {
        **read_palette("../../.config/nvim/colors/solarized.vim"),
        **{
            "base03": "#202020",
            "base02": "#2d2d2d",
            "base01": "#606060",
            "base00": "#6d6d6d",
            "base0": "#969696",
            "base1": "#a0a0a0",
            "base2": "#eaeaea",
            "base3": "#f9f9f9",
        },
    },
}


for name, scheme in COLORSCHEMES.items():
    theme = THEMES[scheme["theme"]]
    palette = PALETTES[scheme["palette"]]

    with open(f"colorscheme.{name}.conf", "w") as f:
        for name, value in scheme.items():
            if name in ("theme", "palette"):
                continue
            s = f"{name} {value.format(**palette)}\n"
            f.write(s)
        for name, value in theme.items():
            s = f"{name} {value.format(**palette)}\n"
            f.write(s)
