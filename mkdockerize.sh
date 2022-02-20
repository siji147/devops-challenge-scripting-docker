#!/bin/bash
input_value=$1

if [ $input_value == produce ]
then
    echo "now packaging documents..."
    mkdocs build
    echo "zipping mkdocs resources..."
    # archive the static assests produced in ./site directory
    tar -czf mkdocs-files.tar.gz ./site
    # archive all files in the mkdocs root directory
    # tar -czf mkdocs-files.tar.gz .
elif [ $input_value == serve ]
then
    echo "extracting static files from archive..."
    tar -xvzf mkdocs-files.tar.gz
    echo "now serving documents..."
    mkdocs serve -a localhost:8000
else
    echo "Invalid command entered. Valid commands are 'serve' and 'produce'"
fi
