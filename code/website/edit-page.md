---
title: Edit a page
layout: code
unique_id: codepage
tab: code
toc: true
author: Emmanuel Bernard
---
# Edit a page (tips and tricks)

#{page.table_of_contents}

Pages are primarily written in Markdown. More complex ones may be written in haml. 
Markdown has a very simple and human readable syntax which is described 
[here](http://daringfireball.net/projects/markdown/syntax).

You can find two sample files for [.md](/code/website/md-sample) and 
[.html.haml](/code/website/haml-sample) syntaxes. Look at them especially the .md file.

There are a few additional tricks and recommendations for you.

### Links between site pages

Files named `index.md` will generate an `index.html` file in the same directory.
However, any other file name will generate a new directory named after the file.
This directory will contain an `index.html` file. The reason for this behavior
is to have more elegent URLs. For example, `/code/website/edit.md` will generate
`/code/website/edit/index.html`.

For that reason, use URLs without the `/index.html` suffix. Likewise, using URLs based
off root is safer in case the page is moved around.

<!-- lang: none -->
    [link to edit](/code/website/edit)

### Syntax highlighting

Blocks of code in Markdown are indented with 4 spaces. By default, highlighting is done
for the Ceylon syntax. You can change the targeted language by adding some specific HTML comment
right before the block of code. You can use:

- Java: &lt;!-- lang: java --&gt;
- Bash: &lt;!-- lang: bash --&gt;
- no highlighting: &lt;!-- lang: none --&gt;

In Bash

<!-- lang: bash -->
    <!-- lang: bash -->
        #!/bin/bash
        if [ ! -d "$HOME/.ceylon" ]; then
            echo "Ceylon rocks"
        fi

In Java 

<!-- lang: java -->
    <!-- lang: bash -->
        public final class Address {
        	public String getStreet() { return street;}
        	public void setStreet(String street) { this.street = street;}
        	private String street;
        }

And in Ceylon

        shared Address(String street) {
        	shared variable street = street;
        }

### Adding an automatic table of content

You can automatically generate the table of content based on the page
metadata:

- Add `toc: true` in the file header
- add `\#{page.table_of_contents}` where you want the table to appear

You should see a table of content similar to the top of this page.

### Referencing the specification or the ceylondoc

If you want to point the spec to a user in the site, point to [/documentation/latest/spec](/documentation/latest/spec).
This page show the spec in HTML, HTML in single page and PDF. You can replace `latest` with a specific `major.minor` 
version (eg `1.0`).

If you want to point to a specific paragraph in the spec, use the variable `site.urls.spec` and
the anchor to the paragraph in the spec.

eg This is a **\[**pointer to the spec**\](\#{site.urls.spec}#**_anchor-in-spec_**)**.

That means the specification anchors should be stable.

Likewise, to point to a ceylondoc entry, use the variable `site.urls.apidocs`.   

**\[**Doc for `Comparable`**\](\#{site.urls.apidoc}**_/ceylon/language/Comparable.html_**)**

By using these placeholders, we will be able to move the spec or ceylondoc to other places.
Note that [/documentation/api](/documentation/api) page is pretty useless as it is but
should be fixed in ceylondoc.

### Linking withing a page

Markdown by itself doesn't allow the author to put `id` attributes or anchors
(`<a name="...">`) in the generated HTML, which is annoying if you want to link 
to a particular part of the page. You can of course put `<a name="...">` 
elements in yourself, but:

* It clutters up the nice markdown with HTML.
* It forces you to ensure the uniqueness of the ids you use.
* It's tedious.

We generate id attributes automatically for all 
`<h*>` and `<p>` elements. For headings we use the heading text (suitably 
munged into an XML NAME). For paragraphs we use the first few words (again 
suitable normalized, and also worrying about uniqueness). If an element 
already has an `id` then it's untouched. If there's a matching `id` 
(or `name`, since they share the same namespace), steps are taken to 
disambiguate the generated one.

The long and the short of this is that we can now easily and accurately link 
into the middle of documents. The *caveat* is that you should be aware that 
changing the first few words of a paragraph (or the text of a heading) is 
likely to break any links which point to it. To prevent such broken links 
you can always use an explicit `<a name="">` at the relevant point.

