---
layout: code
title: Building the website
tab: code

author: Emmanuel Bernard
---

# How to build [ceylon-lang.org](/)

A bit of Git, a bit a Ruby and you will get your local version of [ceylon-lang.org](/) served.

## Infrastructure

* get Git
* get Ruby 1.8
* if on Mac OS, get XCode (needed for native gems)

Install Git to your system. [GitHub's help page](http://help.github.com/) is a good starting
point. [Emmanuel's blog](http://in.relation.to/Bloggers/HibernateMovesToGitGitTipsAndTricks)
on Git tips and tricks is useful too.

Install Awestruct, a Ruby based site generator.

    gem install awestruct 
    #or
    sudo gem install awestruct

The Awestruct version known to work is 0.2.13

    sudo gem install awestruct --version 0.2.13

Get the website source from GitHub.

    git clone git@github.com:ceylon/ceylon-lang.org.git

## Serve the site locally

* Go in your `~/ceylon-lang.org` directory.  
* Run  `awestruct -d`
* Open your browser to <http://localhost:4242>

Any change will be automatically picked up except for `_partials` files, `_base.css`
and sometimes new blog entries.

### How to also include the spec and ceylondoc pages

Use `./build-site.sh`. This will clone or refresh the spec, language and compiler repos 
into `_tmp` and build the appropriate artifacts before pushing them to the site.

If you have already run `./build-site.sh` and don't wish to rebuild the spec and ceylondoc,
use 

    ./build-site.sh --light

to simply copy them to the website structure. This is much faster.

### If your changes are not visible...

If for whatever reason you make some changes which don't show up, you can
completely regenerate the site:

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