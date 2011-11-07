#!/bin/bash
## Copy the latest version of the spec
## as well as the latest version of the ceylon.language ceylondoc
##

cd ..

# Build spec and type checker
cd ceylon-spec
ant
ant publish
cd ..

# Copy spec into website
cp -R ceylon-spec/build/en/ ceylon-lang.org/_site/documentation/spec

# Build language module
cd ceylon.language
ant
cd ..

# Create ceylondoc for ceylon.language and copy it into the website
cd ceylon-compiler
ant
mkdir -p ../ceylon-lang.org/_site/documentation/api/current/
./bin/ceylond -d ../ceylon-lang.org/_site/documentation/api/current/ -sourcepath ../ceylon.language/languagesrc/current/
cd ..

cd ceylon-lang.org