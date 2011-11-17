---
title: FAQs 
layout: faq
toc: true
tab: documentation
unique_id: docspage
author: Emmanuel Bernard
---

# Frequently Asked Questions

We have specialized FAQs for certain important subjects:

* [Language design FAQ](language-design)
* [IDE](ide)

On this page you'll find answers to a few of the most 
common questions about the Ceylon project.  

#{page.table_of_contents}

## Basics

### What is Ceylon?

Ceylon is a new language that's deeply influenced by Java, 
designed by people who are unapologetic fans of Java.


### Why a new language?

Well, we've been designing and building frameworks and 
libraries for Java for ten years, and we know its limitations 
intimately. And we're frustrated. The number one technical 
problem that we simply can't solve to our satisfaction in 
Java - or in any other existing JVM language - is the problem 
of defining user interfaces and structured data using a 
typesafe, hierarchical syntax. Without a solution to this 
problem, Java remains joined at the hip to XML.

But much of our frustration is not even with the Java 
language itself. The extremely outdated class libraries that 
form the Java SE SDK are riddled with problems. Developing a 
great SDK is a top priority of the project.

## Contributing

### How can I contribute to Ceylon?

Ceylon is a semi public community at this stage. A small team 
of contributors (both outside and inside Red Hat)
are working on the spec, the language module, the compiler, the 
IDE etc. Contact Gavin on 
[Google +](https://plus.google.com/105743409453530897815) or 
email him at gavin at hibernate.org if you want to join the team.

### Found a problem, how can I improve the website?

The website is fully open already and you can contribute typos, 
improvements, or new pages very easily. 
[Want more info?](/code/website).

## Technical

### What version of Java is required to run Ceylon?

Today JDK 6. We may make use of the new
`invokedynamic` instruction introduced in Java 7 at some point.

## Other

### What license is Ceylon released under?

The compiler is released under the [GPL v2](http://www.gnu.org/licenses/gpl-2.0.html) + classpath exception 
because it's based on OpenJDK's `javac` compiler.
Other non tainted parts of Ceylon are released under the 
[Apache Software License 2.0](http://www.apache.org/licenses/LICENSE-2.0.html).  

The website is released under 
[Creative Commons Attribution Share-Alike 3.0 Unported (CC BY-SA 3.0)](http://creativecommons.org/licenses/by-sa/3.0/)
