#!/usr/bin/env python

import json
import sys

if len(sys.argv) == 1:
    print("Usage: {} fontawesome_icons.json".format(sys.argv[0]))
    sys.exit(1)

with open(sys.argv[1], "r") as f:
    obj = json.load(f)

points = []
points_brands = []
for icon, data in obj.items():
    styles = data["styles"]
    u = data["unicode"]
    ufmt = "U+{}".format(u.upper())
    if "brands" in styles:
        points_brands.append(ufmt)
        continue
    points.append(ufmt)

pointsfmt = ",".join(points)
configline = "symbol_map {} Font Awesome 5 Free Solid".format(pointsfmt)

pointsfmt_brands = ",".join(points_brands)
configline_brands = "symbol_map {} Font Awesome 5 Brands".format(pointsfmt_brands)

print(configline)
print(configline_brands)
