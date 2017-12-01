---
title: Add a new page
layout: code
unique_id: codepage
tab: code
author: Emmanuel Bernard
toc: true
---
# Add a new page

The best way to add and edit a page is to look how other pages are done and 
start from here. The following page gives you some keys to understand the code.

#{page.table_of_contents}

You can build pages in two formats, Markdown (.md) and haml (`.html.haml`).
The warmly recommend using Markdown.

You can find two sample files for [.md](/code/website/md-sample) and 
[.html.haml](/code/website/haml-sample) syntaxes. Look at them especially the .md file.

## Site structure

The site is separated in a few different (self explanatory) sections

- Home page
- Learn it: the documentation section
- Download: how to download Ceylon
- Community: everything related to forums, mailing lists, events, the team etc
- Code: how to get and hack the Ceylon code and the website
- Blog: the blog entry

Most pages belong to one of these categories and the right tab is highlighted.

## Page metadata

Each page comes with some metadata.

- `title` (mandatory): the page title
- `author` (mandatory): the author or comma separated list of authors
- `tab` (mandatory): the tab that ought to be highlighted 
- `layout` (mandatory): the page layout to use
- `milestone`: the milestone for the feature (will display a milestone tag)
- `toc`: table of content
- `doc_root`: documentation relative URL to root (only useful in the documentation section, see more at [Edit a page](../edit-page/#documentation_section))

Each metadata can be accesssed via `\#{page.metadata}` in your page. For example `\#{page.title}`

### tab (mandatory)
The list of accepted tab names is: `home`, `documentation`, `download`, `code`, `blog`.

### layout (mandatory)

There are several layouts depending on where you are in the website structure:

* `default`: this is the default layout if outside of any specific structure
* `blog`: use this layout of a blog entry
* `code`: use this layout for pages in a code section
* `community`: use this layout for community pages
* `documentation`: use this layout of documentation pages
* `faq`: use this layout for FAQ pages
* `tour`: use this layout for a tour page

If you add a page that ought to be in one of the structure menu, edit its respective `_layout` file. 
Make sure to use absolute links in menus eg `/code/website/add-page`.

### milestone

You can ensure that a milestone tag appears at the top of a page if the feature is planned for a later release.

Available values are `Milestone 1`, `Milestone 2` or `Milestone 3`.

### toc

You can automatically generate the table of content based on the page metadata:

- Add `toc: true` in the file header
- add `\#{page.table_of_contents}` where you want the table to appear

You should see a table of content similar to the top of this page.

## Write the actual page content :)

Check out [Edit a page](/code/website/edit-page).