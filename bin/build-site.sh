#!/bin/bash
## Copy the latest version of the spec
## as well as the latest version of the ceylon.language ceylondoc
##

while [ $# -gt 0 ] ; do
case $1 in
--help) HELP="true" ; shift 1 ;;
--light) LIGHT="true" ; shift 1 ;;
*) shift 1 ;;
esac
done

if [ "$HELP" = "true" ]; then
	echo "Options:"
	echo " --light to only copy files (spec and docs are assumed to be built)"
	echo " --help this help message"
	exit 0;
fi

#move to root
cd ..

# Build site
awestruct --profile production

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
if [ "$LIGHT" != "true" ]; then
	cd ceylon-spec
	git fetch origin
	git checkout origin/master
	ant
	ant publish
	cd ..
fi

# Copy spec into website
cp -R ceylon-spec/build/en/ ../../_site/documentation/1.0/spec
mv ../../_site/documentation/1.0/spec/pdf/Ceylon*.pdf ../../_site/documentation/1.0/spec/pdf/ceylon-language-specification.pdf

# Build language module
if [ "$LIGHT" != "true" ]; then
	cd ceylon.language
	git fetch origin
	git checkout origin/master
	ant
	cd ..
fi

# Create ceylondoc for ceylon.language and copy it into the website
if [ "$LIGHT" != "true" ]; then
	cd ceylon-compiler
	git fetch origin
	git checkout origin/master
	ant build publish
	cd ..
fi
mkdir -p ../../_site/documentation/1.0/api/current/ceylon
./ceylon-compiler/build/bin/ceylond -src -source-code ceylon.language/src ceylon.language
mv modules/ceylon/language/0.1/module-doc ../../_site/documentation/1.0/api/current/ceylon/language

cd ../..
