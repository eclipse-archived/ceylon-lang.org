---
title: Changed syntax highlighting
author: Tom Bentley
layout: blog
unique_id: blogpage
tab: blog
tags: [site]
---

I've been writing quite a lot of [documentation](/documentation/1.0/reference) 
lately, and my [previous decision](/blog/2011/09/26/site-improvements) to require an HTML
comment in order to get syntax highlighting of Ceylon code started to look 
like the wrong choice. 
Since the vast majority of the code blocks on the site are going 
to be Ceylon source, and since we're (almost?) always going to want that
highlighted I've changed the rules:

* Now *all* indented code blocks will be *assumed* to be Ceylon source code
  that requires syntax highlighting, unless indicated otherwise.
* If the source code is not Ceylon, you can use a `<!-- lang: foo -->`
  comment (having setup the syntax highlighter and `gsub` transformer
  to do highlighting for the language `foo`).
* If you don't want any highlighting at all use `<!-- lang: none -->`

