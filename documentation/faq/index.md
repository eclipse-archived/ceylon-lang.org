---
title: FAQs 
layout: faq
toc: true
tab: documentation
author: Emmanuel Bernard
---

# Frequently Asked Questions

We have specialized FAQs for some subjects:

* [Language design FAQ](language-design)

On this page you will find the most common questions.  

#{page.table_of_contents}

## Basics

### What is Ceylon?

Ceylon is a new language that's deeply influenced by Java, designed by people who are unapologetic fans of Java.


### Why a new language? 

Well, we've been designing and building frameworks and libraries for Java for ten years, and we know its limitations intimately. And we're frustrated. The number one technical problem that we simply can't solve to our satisfaction in Java - or in any other existing JVM language - is the problem of defining user interfaces and structured data using a typesafe, hierarchical syntax. Without a solution to this problem, Java remains joined at the hip to XML.

But much of our frustration is not even with the Java language itself. The extremely outdated class libraries that form the Java SE SDK are riddled with problems. Developing a great SDK is a top priority of the project.


## Contributing

### How can I contribute to Ceylon?

Blah

## Technical

### The compiler does not build my module, why?

Blah

### What version of Java is required to run Ceylon?

Either Java 6 or 7, we don't know for sure yet. We may make use of the new
`invokedynamic` instruction introduced in Java 7. If we don't end up needing 
that it should be Java 6 compatible.

## Other

### What license will Ceylon be released under?

[GPL2](http://www.gnu.org/licenses/gpl-2.0.html) 
(or possibly [GPL3](http://www.gnu.org/licenses/gpl-3.0.html)).
