---
title: Home page has a news section
author: Emmanuel Bernard
layout: blog
unique_id: blogpage
tab: blog
tags: [site]
---
The website home page now has an automatically filled news section.

When you want to advertize a news, add a file `yyyy-mm-some-text.md` to `_data/news` with the following structure

<!-- lang: none -->
    ---
    title: 'My exciting news'
    date: 29 August, 2011
    more_info_url: /my/url/with/more/details
    effective_date: 20110829
    ---
    Some exciting news today.

A typical example would be `2011-08-news-section.md`

<!-- lang: none -->
    ---
    title: 'News section is up'
    date: 29 August, 2011
    more_info_url: /blog/2011-08-29-news-section/
    effective_date: 20110829
    ---
    The website news section is now up.

### Note

I could have reused blog entries tagged #news but it turns out that the first 50 characters a
not often useful. So I've decided to go for the explicit `_data/news` structure.