#!/usr/bin/env python

import sys, os, re, subprocess

print(sys.argv)

svg = sys.argv[1]
bin = sys.argv[2]
png = sys.argv[3]
scad = re.sub(r"\.svg$", ".scad", svg)
svgt = svg + ".temp.svg"

print(bin, svg, png, scad)

with open(scad, "wt") as scad_file:
    scad_file.write("import(\"" + svgt + "\", width = 960, height = 720);\n")

with open(svg, 'r') as svg_file:
    svg_content = svg_file.read()

# remove the test-frame rectangle (from the W3C test cases)
svg_content = re.sub(r"<[^>]*id=\"test-frame\"[^>]*>", "<!-- test-frame removed -->", svg_content)

with open(svgt, "wt") as svg_temp_file:
    svg_temp_file.write(svg_content)

subprocess.call([bin, scad, '--render', '--camera=0,0,0,0,0,0,4500', '--imgsize=960,720', '-o', png])
os.remove(scad)
os.remove(svgt)
