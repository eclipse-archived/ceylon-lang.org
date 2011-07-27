---
title: Site is shaping up rapidly &#58; feedback needed
author: Emmanuel Bernard
layout: blog
tags: [ site ]
---
The website is shaping up rapidly.

I need your feedback on:

* the infrastructure
* the structure

The website is available at <git@github.com:ceylon/ceylon-lang.org.git>
To build the site, check out [README.md](/README)

## The infrastructure

As I said initially, the side is a static website built using Awestruct. I need you to have a look at it and **play with it for real** to see if you will be able to live with in in the coming months.
In particular, write pages, (both md and haml files), write blogs, write events. I think Markdown files (.md) will be sufficient for 90% of the pages but everything requiring  custom CSS id / class are better handled with .haml files.

I'm quite pleased with what is present even if that's not perfect by any means and if parsing errors can be quite hard to track. It's probable that at some point in the future, Awestruct won't be sufficient and that we will need better tools for specialized content (like blog, wiki etc). But I would never have been able to achieve what I did alone in such a short time without it.

## The structure

The Play Framework site is very well done and I've shamelessly copied the structure. We of course have much less to show so many areas are different.

### Home

The home page. That's the area I worked the less on, Somebody will have to step up and decide what we put in.

### Learn it

That's everything doc related:

* the Ceylon tour (a shorter version of Gavin's introduction) - not finished btw
* FAQs: this will need to be filled with complier how to s when M1 hits the road. In the mean time, we need to populate it with something.
* Roadmap (I copied the wiki's page)

### Download

Not much to see here, I point to the roadmap

### Community

Pointers to the forum, mailing list and the list of events (conferences etc)

### Code

Not much to see but that will contain:

* pointers to the Git repos
* how to build
* a link to the bug tracking system
* some hand holding for contributors

### Blog

This is not a full featured blogging system yet but one can already write blogs in Markdown, tag them. A feed is generated from this. I put some examples.

## TODOs

For me:

* integrate Disq.us comment system for the blog entries and possibly some other pages
* integrate a forum using an embedded Nabble forum. Btw, do we want a forum before we release some code?
* make the blog system generate per author pages (low priority)
* improve the top nav system (using some ruby code instead of copy paste)
* think about a way to generate the 2nd level nav system. Today that's manual per section.

For you:

* try the system by writing docs and see what you can do
* write documentation or pages where you feel things are missing
* help port the Ceylon introduction to the Tour format (ie getting rid of the whys and detailed explanations to focus on showing the features)

