#!/bin/bash

FILES=*.ipynb
for f in $FILES
do
  echo "Processing $f file..."
  base=${f%.*}
  jupyter nbconvert --RegexRemovePreprocessor.patterns="['.*Expand for Solution.*']" --to html --output ${base}_Solutions "$f" 
  wkhtmltopdf "${base}_Solutions.html" "${base}_Solutions.pdf"
  jupyter nbconvert  --RegexRemovePreprocessor.patterns="['.*Expand for Solution.*', '.*\*\*\*Solution\*\*\*.*']" --to html "$f" 
  wkhtmltopdf "${base}.html" "${base}.pdf"
# we'd like to automatically create a notebook with no solution cells, but it doesn't seem to work
#  jupyter nbconvert --RegexRemovePreprocessor.patterns="['.*Expand for Solution.*', '.*\*\*\*Solution\*\*\*.*']" --output ${base}_NoSolutions --to ipynb "$f" 
done
