#!/bin/bash

FILES=*.ipynb
for f in $FILES
do
  echo "Processing $f file..."
  base=${f%.*}
  jupyter nbconvert --execute --to html --output ${base}_Solutions "$f" 
  wkhtmltopdf "${base}_Solutions.html" "${base}_Solutions.pdf"
  jupyter nbconvert --execute --TagRemovePreprocessor.enabled=True  Assignment_01_Companion.ipynb --TagRemovePreprocessor.remove_cell_tags="['solution']" --to html "$f" 
  wkhtmltopdf "${base}.html" "${base}.pdf"
done
