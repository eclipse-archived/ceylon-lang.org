---
title: Wire the site with spec and ceylondoc 
author: Emmanuel Bernard
layout: blog
unique_id: blogpage
tab: blog
tags: [site]
---
The site now integrates the specification and the ceylondoc for `ceylon.language`.

## How to build the integrated site

Run `./build-site.sh` from the root of your `ceylon-lang.org` repository.
This will 

- clone or refresh the ceylon-spec, ceylon.language and ceylon-compiler
repos 
- build the documentation as of the latest in master
- push the bits in the generated directory of awestruct

Navigation from the site proper to the spec or the ceylon.language doc should work
when serving the awestruct website.

## How to reference the spec or the ceylondoc

If you want to point the spec to a user in the site, point to [/documentation/1.0/spec](/documentation/1.0spec).
This page show the spec in HTML, HTML in single page and PDF.

If you want to point to a specific paragraph in the spec, use the variable `site.urls.spec` and
the anchor to the paragraph in the spec.

eg This is a **\[**pointer to the spec**\](\#{site.urls.spec}#**_anchor-in-spec_**)**.

That means the specification anchors should be stable.

Likewise, to point to a ceylondoc entry, use the variable `site.urls.apidocs`.   

**\[**Doc for `Comparable`**\](\#{site.urls.apidoc}**_/ceylon/language/Comparable.html_**)**

By using these placeholders, we will be able to move the spec or ceylondoc to other places.
Note that [/documentation/1.0/api](/documentation/1.0/api) page is pretty useless as it is but
should be fixed in ceylondoc.

