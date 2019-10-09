#!/usr/bin/env python

def parse_line(line):
    cleaned = line.strip()
    split = cleaned.split(maxsplit=1)
    if not split:
        return None, None
    if len(split) < 2:
        return split[0], None
    return split

def parse_variables(section):
    parsed = {}
    with open("colorscheme.variables.conf", "r") as f:
        current_section = None
        for line in f:
            key, value = parse_line(line)
            if key == "!":
                current_section = value
                continue
            if current_section == section:
                parsed[key] = value
    del parsed[None]
    return parsed

common = parse_variables("Common")
for scheme in ("Dark", "Light"):
    variables = parse_variables(scheme)
    
    with open("colorscheme.template.conf", "r") as f:
        template = f.read()

    rewritten = template
    for key, value in variables.items():
        rewritten = rewritten.replace(key, value)
    for key, value in common.items():
        rewritten = rewritten.replace(key, value)

    save_as = "colorscheme.{}.conf".format(scheme.lower())
    with open(save_as, "w") as f:
        f.write(rewritten)
    
