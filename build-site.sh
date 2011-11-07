#!/bin/bash
## Copy the latest version of the spec
## as well as the latest version of the ceylon.language ceylondoc
##

# Build site
awestruct --profile development

# Update the repos
REPOS="_tmp/repos"
mkdir -p $REPOS

cd $REPOS
if [ ! -d "ceylon-spec" ]; then
	git clone git@github.com:ceylon/ceylon-spec.git
fi
if [ ! -d "ceylon.language" ]; then
	git clone git@github.com:ceylon/ceylon.language.git
fi
if [ ! -d "ceylon-compiler" ]; then
	git clone git@github.com:ceylon/ceylon-compiler.git
fi

# Build spec and type checker
cd ceylon-spec
git fetch origin
git checkout origin/master
ant
ant publish
cd ..

# Copy spec into website
cp -R ceylon-spec/build/en/ ../../_site/documentation/spec

# Build language module
cd ceylon.language
git fetch origin
git checkout origin/master
ant
cd ..

# Create ceylondoc for ceylon.language and copy it into the website
cd ceylon-compiler
git fetch origin
git checkout origin/master
ant build
mkdir -p ../../../_site/documentation/api/current/
./bin/ceylond -d ../../../_site/documentation/api/current/ -sourcepath ../ceylon.language/languagesrc/current/
cd ..

cd ../..