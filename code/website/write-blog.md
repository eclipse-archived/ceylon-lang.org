---
title: Write a blog entry
layout: code
tab: code
author: Emmanuel Bernard
---
# #{page.title}

A blog is like any other page written in Markdown. Make sure to use the layout `blog`
and make sure to add tags to your blog.

Blogs appear under [/blog](/blog) and are also classified by author and tag. 

To create a blog entry, create a file named `YYYY-MM-DD-some-title.md` in`/blog` and add the 
following metadata

<!-- lang: none -->
    ---
    title: Announcing the best thing since sliced bread
    author: Emmanuel Bernard
    layout: blog
    tags: [annouce, bread]
    ---

As you can see, you can have several tags.

Note that unfortunately, the index, tags and author pages are not generated when a blog entry is added.
`rm -f _site/blog` to force the generation.