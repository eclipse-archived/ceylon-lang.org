---
title: 'Ceylon hands-on at JUDCon Boston 2013'
presentor: 'Gavin King, Emmanuel Bernard and St&#233;phane &#201;pardaud'
event: JUDCon Boston 2013
event_date: 10 June 2013
event_url: http://www.jboss.org/events/JUDCon/2013/unitedstates/agenda/jbossworkshops.html
location: Boston, USA
effective_date: 20130610
---

Gavin, Emmanuel and Stéphane will be at this year's Boston JUDCon for a 
[4h Ceylon hands-on](http://www.jboss.org/events/JUDCon/2013/unitedstates/agenda/jbossworkshops.html), split in
two 2h parts on Monday, June 10th.

During this session, we will help you learn the Ceylon programming language, hand in hand, 
from downloading the tools, using the IDE, getting to know the various tools, the language SDK, 
all the way to running your own module repository and publishing your first Ceylon modules to it 
and to the official Ceylon module repository.

No edge of Ceylon required, though the audience should be familiar with the Java programming language.

The first part of the workshop (10:00am - 12:00pm) will get you familiar with the Ceylon IDE and its command-line tools, 
as well as the basics of the language: the new type system, how to work with lists, 
functional programming and how to write classes and interfaces.

During the second part (1:00pm - 3:00pm), we will examine more advanced topics, such as using the Ceylon SDK to 
write a REST client, and even as ambitious as writing the ceylon.html SDK module
from scratch and publishing it on Herd, our module repository.

Please take the time to download, install and check the following things to make the hands-on as smooth as possible,
since it's not fun to spend too much time on installation:

- Install the [Java 7 JDK](http://java.com/en/download/index.jsp), and configure it as the default JDK
- [Install the command-line distribution of Ceylon](http://ceylon-lang.org/download/) (M5 Version)
- If you did not manage to configure Java 7 as the default JDK on Windows, define the JAVA_HOME environment variable in 
your systems properties so that it points to your JDK 7 installation
- Check that the Ceylon command-line tools run: `ceylon --version` must print the correct version of Ceylon (M5)
- Install [Eclipse Juno](http://www.eclipse.org/downloads/) and the [Ceylon IDE](http://ceylon-lang.org/download/) (or using [our update site](http://ceylon-lang.org/documentation/1.0/ide/install/)) 
- Check that you can create a new Ceylon project from within the Ceylon IDE and that you can launch it as a 
`Ceylon Application` (make a `demo` project with `Hello Word!` to test)
- Finally check that the Ceylon command-line tools work in your project as well: in your `demo` Ceylon 
project's folder, the `ceylon compile demo` command should compile your project (provided you named your Ceylon 
module `demo`), and `ceylon run demo/1` (provided you named your version `1`) should print `Hello World!`

Make sure you register, because this is going to be another great JUDCon!
