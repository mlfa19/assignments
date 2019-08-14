#!/bin/bash

if [ $# -ne 2 ]; then
  echo "USAGE: ./make_new_document.sh module-number document-name"
  exit 1
fi

echo "Creating document directories..."
if [ ! -d "../Module ${1}" ]; then
  mkdir "../Module ${1}"
fi

document_name=$2

document_dir="../Module $1/${document_name}"
if [ -d "$document_dir" ]; then
  echo "${document_dir} already exists."
  exit 1
else
  mkdir "$document_dir"
fi

echo "Copying document files..."
 

cp ../templates/nonassignment.tex "${document_dir}/${document_name}.tex"

sed "s/@default_files.*$/@default_files = ('${document_name}.tex');/g" ../templates/latexmkrc > "${document_dir}/latexmkrc"

echo "Done..."
