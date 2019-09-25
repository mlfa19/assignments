#!/bin/bash

usage() { echo "Usage: $0 [-x]" 1>&2; exit 1; }

execute_flag=""
while getopts ":x" o; do
    case "${o}" in
        x)
            execute_flag="--execute"
            ;;
        *)
            usage
            ;;
    esac
done

FILES=*.ipynb
for f in $FILES
do
  echo "Processing $f file..."
  base=${f%.*}
  jupyter nbconvert ${execute_flag} --RegexRemovePreprocessor.patterns="['.*Expand for Solution.*']" --to html --output ${base}_Solutions "$f" 
  wkhtmltopdf "${base}_Solutions.html" "${base}_Solutions.pdf"
  jupyter nbconvert  --RegexRemovePreprocessor.patterns="['.*Expand for Solution.*', '.*\*\*\*Solution\*\*\*.*']" --to html "$f" 
  wkhtmltopdf "${base}.html" "${base}.pdf"
# we'd like to automatically create a notebook with no solution cells, but it doesn't seem to work
#  jupyter nbconvert --RegexRemovePreprocessor.patterns="['.*Expand for Solution.*', '.*\*\*\*Solution\*\*\*.*']" --output ${base}_NoSolutions --to ipynb "$f" 
done
