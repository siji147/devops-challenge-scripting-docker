#!/bin/bash
input_value=$1

if [ $input_value == serve ]
then
    echo "now serving documents..."
    mkdocs serve
elif [ $input_value == produce ]
then
    echo "now packaging documents..."
else
    echo "Invalid command entered. Valid commands are 'serve' and 'produce'"
fi
