---
title: Write a blog entry
layout: code
unique_id: codepage
tab: code
author: Emmanuel Bernard
---
# #{page.title}

The site has a section about [upcoming talks](/community/events)
which is built based on the data in `_data/events_`.

Create a file `yyyy-event-name.md` under `_data/events_` with the following 
metadata

<!-- lang: none -->
    ---
    title: 'Introducting Ceylon'
    presentor: Gavin King
    event: InfoQ Beijing
    event_date: 10 April, 2011
    event_url: http://www.qconbeijing.com/ShowNews.aspx?id=65
    location: Beijing, China
    effective_date: 20110410
    ---
    Gavin will unveal a new JVM based programming language that he and his team 
    have been working on for a while.

The syntax uses Markdown like everything on the website. `effective_date` is dictate the order
envents are displayed and is in absolute data format `yyyymmdd`. 

Note that unfortunately, the index page is not generated when an event entry is added.
You need to `rm -f _site/community/events` and have `awestruct -d` running.