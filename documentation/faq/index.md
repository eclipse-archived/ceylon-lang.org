---
title: FAQs 
layout: faq
toc: true
tab: documentation
unique_id: docspage
author: Emmanuel Bernard
---

# Frequently Asked Questions

On this page you'll find answers to a few of the most 
common questions about the Ceylon project.  

#{page.table_of_contents}

## Basics

### What is Ceylon?

Ceylon is a new programming language that's deeply influenced 
by Java, designed by people who are unapologetic fans of Java. 
It's a language designed specifically for writing large 
programs in teams.

### Where can I run Ceylon?

You can run Ceylon anywhere a Java Virtual Machine is available.
The Ceylon compiler uses the bytecode generator in Open JDK to 
produce Java bytecode.

We're also working on a second compiler backend which produces
JavaScript instead of Java class files, so that you can use
Ceylon in a web browser or on `node.js`.

### Why a new language?

Well, we've been designing and building frameworks and 
libraries for Java for ten years, and we know its limitations 
intimately. And we're frustrated. 

The number one technical problem that we simply can't solve 
to our satisfaction in Java - or in any other existing JVM 
language - is the problem of defining user interfaces and 
structured data using a typesafe, hierarchical syntax. 
Without a solution to this problem, Java remains joined at 
the hip to XML.

But much of our frustration is not even with the Java 
language itself. The extremely outdated class libraries that 
form the Java SE SDK are riddled with problems. Developing a 
great SDK is a top priority of the project.

### How is Ceylon different?

Every language has its strengths and weaknesses. Ceylon is
a great language if you want to create easily understandable
and maintainable code with minimum fuss, especially if you
like navigating and writing code with the help of an IDE. It's
also an especially great language if you care about 
modularity.

There are [five important concerns](/blog/2012/01/10/goals/)
that guide the design of the language and platform.

### How about Java interoperability?

Java interoperability is a major priority for the project.
However, since Ceylon will be based on its own modular SDK,
making a clean break from the legacy Java SDK, Ceylon will 
require new frameworks designed especially for Ceylon. That's 
reasonable, since Ceylon is a _much_ nicer language for
developing frameworks and libraries than Java!

### Where can I read more about some of your language design choices?

Try the [language design FAQ](language-design).

## The project and team

### Who's behind this project?

Ceylon is a community project sponsored by Red Hat. You can
read more about the team [here](/community/team/).

### When will it be ready?

When it's finished ;-)

Seriously, it's impossible to give anything like an exact 
date, but we're planning for a 1.0 release later this year.

### How is Ceylon pronounced?

There's some debate about that but the accepted pronounciation 
in the team is [/sɨˈlɒn/](http://en.wikipedia.org/wiki/Wikipedia:IPA_for_English#Key).
Or in less fancy schmancy phoneticsy, `selón`.

## Contributing

### How can I contribute to Ceylon?

Are you interested in joining the team and helping improve 
the Ceylon language, the compiler, the class libraries, or 
the IDE? Then contact us on our 
[dev mailing list](http://groups.google.com/group/ceylon-dev).

Want to get your hands on the code? Read how to access 
[the source](/code/source/).

Feeling adventurous and want to help us with the compiler 
backend? Read about [how to work on that project](/code).

### Found a problem, how can I improve the website?

The website is fully open already and you can contribute 
typos, improvements, or new pages very easily. 
[Want more info?](/code/website).

## Technical

### What version of Java is required to run Ceylon?

Today JDK 6. We may make use of the new `invokedynamic` 
instruction introduced in Java 7 at some point.

### Can you tell me more about how it works?

You can read up on the [architecture](/code/architecture).

## Other

### What license is Ceylon released under?

All the code, the language specification, and even our 
website is open source. It's extremely important to us that 
the entire platform be open and unencumbered. 
[Read more](/code/licenses).

### What is the elephant's name?

His name is "Trompon".
