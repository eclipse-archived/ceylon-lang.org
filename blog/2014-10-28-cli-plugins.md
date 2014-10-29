---
title: Ceylon command-line plugins
author: St&#233;phane &#201;pardaud
layout: blog
unique_id: blogpage
tab: blog
tags: [tools]
---

With Ceylon we try our best to make every developer’s life easier. We do this with a great
language, [a powerful IDE](/documentation/1.1/ide/), 
[a wonderful online module repository](/documentation/1.1/reference/repository/modules.ceylon-lang.org/),
but also with an amazing [command-line interface (CLI)](/documentation/1.1/reference/tool/ceylon/).

Our command line is built around the idea of _discoverability_ where you get a single executable called
`ceylon` and lots of subcommands that you can discover via `--help` or completion. We have a number
of [predefined subcommands](/documentation/current/reference/tool/ceylon/subcommands/index.html), but
every so often, we want to be able to write new subcommands.

For example, I want to be able to invoke both Java and JavaScript compilers and generate the API documentation
in a single command `ceylon all`, or I want to be able to invoke the 
[`ceylon.formatter`](http://modules.ceylon-lang.org/modules/ceylon.formatter) module with
`ceylon format` instead of `ceylon run ceylon.formatter`.

Well, with Ceylon 1.1 we now [support custom subcommands](/documentation/1.1/reference/tool/plugin/), 
fashioned after the `git` plugin system. They’re easy to write: just place them in `script/your/module/ceylon-foo` 
and package them with `ceylon plugin pack your.module`, and you can publish them to Herd.

Now every one can install your CLI plugin with `ceylon plugin install your.module/1.0` and call them with
`ceylon foo`.

What’s even better is that they will be listed in the `ceylon --help` and even work with autocompletion.

`ceylon.formatter` uses one, and I encourage you to install them with `ceylon plugin install ceylon.formatter/1.1.0`
and format your code at will with `ceylon format` :)

`ceylon.build.engine` also defines one and it just feels great being able to build your Ceylon project with
`ceylon build compile`, I have to say. Although, unfortunately that particular module has not yet been
published to Herd yet, but hopefully it will be pushed soon.

You can find out [all about them in our reference](/documentation/1.1/reference/tool/plugin/).