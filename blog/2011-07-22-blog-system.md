---
title: We now have a blog system and decent structure
author: Emmanuel Bernard
layout: blog
tab: blog
tags: [ test ]
---
We are at a stage where the website starts to look decent content wise. 

I have recently added the notion of [upcoming talks](/community/events)
which is built based on the data in `_data/events_`.

I have also added the blog system:

In `blog`, create a file `YYYY-MM-DD-some-title.md` and add the following metadata

    ---
    title: We now have a blog system and decent structure
    author: Emmanuel Bernard
    layout: blog
    tags: [site blog]
    ---

Then write down your blog post in [Markdown](/md-sample.md).

Note that unfortunately, the index page is not generated when a blog entry is added.
You need to `rm -f _site` and restart Awestruct.