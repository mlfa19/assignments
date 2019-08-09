#!/bin/bash

latexmk
convert_ipynb.sh
wkhtmltopdf Assignment\ 01\ Companion.html test.pdf
