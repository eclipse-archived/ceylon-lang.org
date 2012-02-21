#!/bin/bash
if [ -z "$1" ]
then
    echo "copy-resource-to.sh <root-of -eylon-lang.org>"
else 
    rsync -avz --delete --progress ../_site/documentation/1.0/spec/html ../_site/documentation/1.0/spec/html_single ../_site/documentation/1.0/spec/pdf ../_site/documentation/1.0/spec/shared $1/documentation/1.0/spec
    rsync -avz --delete --progress ../_site/documentation/1.0/api $1/documentation/1.0/api
fi
