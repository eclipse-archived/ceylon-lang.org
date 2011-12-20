#!/bin/bash
if [ -z "$1" ]
then
    echo "copy-resource-to.sh <root-of -eylon-lang.org>"
else 
    rsync -avz --delete --progress ../_site/documentation/spec/html ../_site/documentation/spec/html_single ../_site/documentation/spec/pdf ../_site/documentation/spec/shared $1/documentation/spec
    rsync -avz --delete --progress ../_site/documentation/api/current $1/documentation/api
fi
