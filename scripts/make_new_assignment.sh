#!/bin/bash

if [ $# -ne 2 ]; then
  echo "USAGE: ./make_new_assignment.sh module-number assignmnet-number"
  exit 1
fi

echo "Creating assignment directories..."
if [ ! -d "../Module ${1}" ]; then
  mkdir "../Module ${1}" 
fi

assignment_number_formatted=$(printf %02d $2)

assignment_dir="../Module $1/${assignment_number_formatted}"
if [ -d "$assignment_dir" ]; then
  echo "${assignment_dir} already exists."
  exit 1
else
  mkdir "$assignment_dir"
fi

echo "Copying assingment files..."
 

sed "s/assignment01_Solutions/assignment${assignment_number_formatted}_Solutions/g" ../templates/assignment01.tex > "${assignment_dir}/assignment${assignment_number_formatted}.tex"

sed "s/assignment01/assignment${assignment_number_formatted}/g" ../templates/assignment01_Solutions.tex > "${assignment_dir}/assignment${assignment_number_formatted}_Solutions.tex"

cp  ../templates/latexmkrc "${assignment_dir}"

echo "Done..."
