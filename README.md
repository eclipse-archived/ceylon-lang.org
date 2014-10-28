---
layout: code
title: Building the website
tab: code

author: Emmanuel Bernard
---

# How to build [ceylon-lang.org](/)

A bit of Git, a bit a Ruby and you will get your local version of [ceylon-lang.org](/) served.

## Installation

* get Git
* get Ruby 1.9 (part of the RVM install if you follow that path - see below)
* if on Mac OS, get XCode (needed for native gems)
* If on Linux:
    * Get libxslt-devel - eg via `sudo yum install libxslt-devel`
    * may be called libxslt1-dev for some distros - eg `sudo apt-get install libxslt-dev`


Install Git to your system. [GitHub's help page](http://help.github.com/) is a good starting
point. [Emmanuel's blog](http://in.relation.to/Bloggers/HibernateMovesToGitGitTipsAndTricks)
on Git tips and tricks is useful too.

Ruby like many other platforms has its dependency hell. We do recommend you use RVM to
isolate your dependencies. The RVM steps are optional though.

Install [RVM](https://rvm.io).

Then set up the isolated environment

    rvm install 1.9.3
    rvm use 1.9.3
    rvm gemset create awestruct

Next, let's retrieve the website.


<!-- lang: bash -->
    git clone git@github.com:ceylon/ceylon-lang.org.git
    cd ceylon-lang.org

If you use RVM, add a `.rvmrc` file in the directory containing

    rvm ruby-1.9.3@awestruct

This will set up the right environment when you enter the directory.
The first time, leave and reenter the directory `cd ..;cd ceylon-lang.org`.

Finally, let's install Awestruct

<!-- lang: bash -->
    gem install bundler
    # or sudo gem install bundler on Mac OS X if you don't use RVM
    bundle install

Note that if someone updates Awestruct or any dependent gem via the `Gemfile` dependency
management, you need to rerun `bundle install`, but before that you have to delete the
`Gemfile.lock` file.

## Serve the site locally

* Run  `awestruct -d`
* Open your browser to <http://localhost:4242>

Any change will be automatically picked up except for `_partials` files, `_base.css`
and sometimes new blog entries.

### How to also include the spec and `ceylon doc` pages

Use `./build-site.sh`. This will clone or refresh the spec, language and compiler repos 
into `_tmp` and build the appropriate artifacts before pushing them to the site.

If you have already run `./build-site.sh` and don't wish to rebuild the spec and ceylondoc,
use 

<!-- lang: bash -->
    ./build-site.sh --light

to simply copy them to the website structure. This is much faster.

### If your changes are not visible...

If for whatever reason you make some changes which don't show up, you can
completely regenerate the site:

<!-- lang: bash -->
    awestruct -d --force

### If serving the site is slow...

On Linux, serving the file may be atrociously slow 
(something to do with WEBRick).

Use the following alternative:

* Go in your `~/ceylon-lang.org` directory.  
* Run  `awestruct --auto -P development`
* In parallel, go to the `~/ceylon-lang.org/_site` directory
* Run `python -m SimpleHTTPServer 4242`

You should be back to millisecond serving :) 

# License

The content of this repository is released under 
[Creative Commons Attribution Share-Alike 3.0 Unported (CC BY-SA 3.0)](http://creativecommons.org/licenses/by-sa/3.0/).
Sample code available on this website is released under [Apache Software License 2.0](http://www.apache.org/licenses/LICENSE-2.0.html).

By submitting a "pull request" or otherwise contributing to this repository, you
agree to license your contribution under the respective licenses mentioned above.

## Acknowledgements

This website uses:

- Icons from [Komodo Media, Rogie King][Komodo] (CC BY-SA 3.0 with link back to the creator)

[Komodo]: http://www.komodomedia.com
