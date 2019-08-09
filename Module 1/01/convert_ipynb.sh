#!/bin/bash

FILES=*.ipynb
for f in $FILES
do
  echo "Processing $f file..."
  base=${f%.*}
  jupyter nbconvert --execute --to html "$f" 
  wkhtmltopdf "${base}.html" "${base}.pdf"
done
