---
title: Write in Ceylon, Deploy as OSGI, use in JEE
author: David Festal
layout: blog
unique_id: blogpage
tab: blog
tags: [osgi]
---
Write in Ceylon, Deploy in OSGI, Use in JEE
===========================================

_... or How to push Ceylon inside JEE applications_


The Ceylon language is inherently modular, and is shipped with a complete infrastructure that allows leveraging this modularity out-of-the box.

However Ceylon is _not captive of its own infrastructure_: After the Java and JS interoperability efforts, the 1.1.0 version has brought out-of-the-box compatibility with OSGI.

Every module archive produced by the Ceylon compiler contains OSGI headers in its MANIFEST file, that describes the module as it should seen by the OSGI container.

Containers tested so far are: 
- Apache Felix 4.4.1, 
- Oracle Glassfish v4.1, 
- Equinox platform, 
- JBoss WildFly 8.0.0.alpha3 (with JBossOSGi installed)

Of course, the Ceylon distribution and SDK modules should first be added inside the OSGI container as OSGI bundles. 

But instead of writing long explanations here, let me direct you to some concrete examples provided, with the required instructions, in the following repository:

https://github.com/davidfestal/Ceylon-Osgi-Examples/

For the moment, it contains a single example that, though very simple, will give you the main steps to start.

It also shows the use of a Ceylon module _totally outside Ceylon's standard infrastructure_, even _totally outside the JBoss world_: in a **Web application servlet running on a Glassfish v4.1 application server**. But of course you should be able to run it inside other OSGI-enabled application servers or containers.

In the next examples we'll try to go further an do more interesting things such as providing services, using Ceylon annotations (which are compatible with Java annotations), or using OSGI services.

Please report any problem you might encounter while testing, and feel free to submit pull requests for any other successful use cases  you might have built.

Looking forward for your remarks, and for the time to write the following examples.
