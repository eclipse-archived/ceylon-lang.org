---
layout: documentation
title: Building the website
tab: documentation
author: Emmanuel Bernard
---
# How to build the ceylon-lang.org website

Building the website and work the documentation is fairly simple. It is based
on `Markdown` or `haml` based files and use Git as a rudimentary CMS.

## infrastructure

You need to:

* get Ruby
* if on Mac OS, get XCode (needed for native gems)
* `gem install awestruct` or `sudo gem install awestruct`
* `git clone git@github.com:ceylon/ceylon-lang.org.git;cd ceylon-lang.org`

The Awestruct version known to work is 0.2.3

   sudo gem install awestruct --version 0.2.3

## Serve the site locally

* Go in your `~/ceylon-lang.org` directory.  
* Run  `awestruct -d`
* Open your browser to <http://localhost:4242>

Any change will be automatically picked up except for `_partials` files, `_base.css`
and sometimes new blog entries.

### How to also add the spec and ceylondoc pages

Use `./build-site.sh`. This will clone the spec, language and compiler repos and build
the appropriate artifacts before pushing them to the site.

Note that this process is a bit slow but you only need to do it if 
the spec or the language have changed or if you have deleted the website.

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

## Markup samples

You can find two sample files for [.md](/md-sample) and 
[.html.haml](/haml-sample) syntaxes. Look at them especially the .md file as it 
shows how a page should be written and how to use syntax highlighting.          
Don't yell at me on color / style, this work has not been done yet.

Menus are in `_layout`. When you create a page, give it the right metadata:

* `title`
* `author`
* `tab`: this is the tab that will be highlighted when the page is shown. Use the lower case menu name.
* `layout`

There are several layouts depending on where you are in the website structure:

* `default`: this is the default layout if outside of any specific structure
* `blog`: use this layout of a blog entry
* `community`: use this layout for community pages
* `documentation`: use this layout of documentation pages
* `faq`: use this layout for FAQ pages
* `tour`: use this layout for a tour page

If you add a page that ought to be in one of the structure menu, edit its respective `_layout` file. Make sure to use absolute links in menus eg `/documentation/faq/language-design`.