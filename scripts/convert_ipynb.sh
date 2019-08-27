#!/bin/bash

FILES=*.ipynb
for f in $FILES
do
  echo "Processing $f file..."
  base=${f%.*}
  jupyter nbconvert --execute --to html --output ${base}_Solutions "$f" 
  wkhtmltopdf "${base}_Solutions.html" "${base}_Solutions.pdf"
  jupyter nbconvert --execute --RegexRemovePreprocessor.patterns="['.*Notebook Exercise .* Solution.*']" ${base}.ipynb --to html "$f" 
  wkhtmltopdf "${base}.html" "${base}.pdf"
done
