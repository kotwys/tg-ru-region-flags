#!/usr/bin/env sh

if which inkscape &>/dev/null
then
  INKSCAPE=inkscape
elif flatpak run org.inkscape.Inkscape -V &>/dev/null
then
  INKSCAPE="flatpak run org.inkscape.Inkscape"
else
  1>&2 echo Could not find Inkscape executable.
  exit 1
fi

ROOT=$(dirname $0)
FILES="$ROOT"/src/*.svg
if [[ $# -gt 0 ]]
then
  FILES=$@
fi

for f in $FILES
do
  echo Converting $f
  OUT_FILENAME=$(basename "$f" | sed 's:\.svg$:\.png:')
  $INKSCAPE -w 100 -h 100 --export-filename="$ROOT/dist/100x100/$OUT_FILENAME" "$f"
  $INKSCAPE -w 512 -h 512 --export-filename="$ROOT/dist/512x512/$OUT_FILENAME" "$f"
done
