---
title: FAQs for IDE
layout: faq
toc: true
tab: documentation
unique_id: docspage
author: Emmanuel Bernard
---

# FAQ on language design

#{page.table_of_contents}

## The tab key does not work anymore

This is a bug in Eclipse or IMP plugin. Restart Eclipse. We are working on but it's an heisenbug bug. You know how it goes.

## The IDE crashes when I activate Ceylon builder on my project

... and subsequently crashes opon start up.

This is an [identified bug](https://github.com/ceylon/ceylon-ide-eclipse/issues/107). We are working on it.
In the mean time, make sure to install the `ceylon.language` module

<!-- lang: bash -->
    git clone https://github.com/ceylon/ceylon.language.git
	cd ceylon.language
	ant

You should be good to go.