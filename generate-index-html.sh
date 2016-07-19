#!/bin/bash

export_table () {
	SECTION="$1"
	INFO="$2"
	OUTPUT="./index-${SECTION}.html"

	cat > "$OUTPUT" <<EOF
<html>
<head>
<title>svglibtest - ${SECTION}</title>
</head>
<body>
<h1>svglibtest - ${SECTION}</h1>
<p>Comparison table between the OpenSCAD test-case images and reference images rendered from the same SVG source by ImageMagick or Inkscape or provided by the test suite.</p>
<p>${INFO}</p>
<p>[ <a href="index-w3c.html">w3c test suite</a> ] - [ <a href="index-spec.html">svg spec</a> ] - [ <a href="index-openclipart.html">openclipart</a> ]</p>
<table>
EOF
	for a in "${SECTION}"-*-expected.png
	do
		NAME=${a%%-expected.png}
		ORIG=${NAME}.png
		echo "<tr><td colspan=\"2\"><hr size=\"3\" style=\"color:blue; background-color:blue;\"></td></tr>" >> "$OUTPUT"
		echo "<tr><td colspan=\"2\"><code><a id="${NAME}" href="#${NAME}">$NAME</a></code></td></tr>" >> "$OUTPUT"
		echo "<tr><td><img border=\"1\" width=\"480\" height=\"360\" src=\"$a\"></td><td><img border=\"1\" src=\"${ORIG}\"></td></tr>" >> "$OUTPUT"
		if [ ! -f "$ORIG" ]
		then
			convert -verbose -density 600 -resize 480x360 -gravity center -extent 480x360 ../../../testdata/svg/openclipart/${NAME}.svg ${ORIG}
		fi
	done
	echo "</table></body></html>" >> "$OUTPUT"
}

export_table w3c 'SVG Sources and reference images from <a href="http://www.w3.org/Graphics/SVG/WG/wiki/Test_Suite_Overview">W3C SVG Test Suite</a>.'
export_table spec 'SVG Sources from the <a href="http://www.w3.org/TR/SVG/">SVG Spec</a>.'
export_table openclipart 'SVG Sources from <a href="https://openclipart.org/">openclipart</a>.'
