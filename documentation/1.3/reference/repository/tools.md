---
layout: reference13
title_md: 'Dealing with repositories on the command line'
tab: documentation
unique_id: docspage
author: Tako Schotanus
doc_root: ../../..
---

# #{page.title_md}

Quite a number of the `ceylon` sub commands deal with [module repositories](..), and 
all of them support at least a basic set of options to change the default behavior 
for dealing with them.

But let's first start by detailing what exactly *is* the default behavior.

### Default repository lookup

Almost all tools that deal with repositories will either have to look up specific 
modules or they need to search for modules using certain search criteria. If, for 
example, you typed `ceylon run my.module/1.2.3`, the system would go look for a module 
named "my.module" with version "1.2.3" and see if there's a artifact containing 
compiled code for the Java Virtual Machine.

Now, by default, Ceylon goes looking in a fixed list of repositories in the exact 
order as shown below, choosing the first module that matches:

- **SYSTEM** &mdash; the **distribution repository**, which is located wherever 
  Ceylon is installed, at `$CEYLON_HOME/repo`. It contains the modules required by 
  Ceylon itself and all its tools.
- **CACHE** &mdash; the **cache repository** which, by default, is located in 
  `$HOME/.ceylon/cache`, and contains every module that was at some point downloaded 
  from a remote server.
- **LOCAL** &mdash; the **local repository** refers to a repository found in the 
  current directory where the tool is executed. By default this will be a directory 
  named `modules`.
- **USER** &mdash; the **user repository**, normally located in `$HOME/.ceylon/repo`,
  holds the modules that are available to the user anywhere on their system 
  regardless of the current folder in which the Ceylon tool is executed.
- **REMOTE** &mdash; the **Herd**, the official [remote Ceylon repository][Herd],
  containing all the Ceylon platform modules, along with many other freely available 
  third party modules. By default this is <https://herd.ceylon-lang.org>.
- **MAVEN** &mdash; the **Maven repository**, where Maven artifacts are obtained.
  The actual Maven module repositories searched by Aether depend upon the user's
  `.m2/settings.xml` file.
 
[Herd]: https://herd.ceylon-lang.org

If the module you need is available in any of the above repositories, you won't have 
to do a thing to run it, copy it, query it or whatever else you want. All the tools 
that deal with repositories will be able to find it by default.

But what if your module is stored somewhere else?

### Specifying repositories

To specify that you want to add another repository that isn't in the above list, you 
must use the `--rep` command line argument, for example:

<!-- lang: none -->
    --rep /path/to/my/repository

Of course you can refer to remote servers as well:

<!-- lang: none -->
    --rep https://herd.mycompany.example.com

You can even specify [Maven repositories][], indirectly, by pointing to a Maven
`settings.xml` file:

    --rep maven:/path/to/special/settings.xml

[Maven repositories]: ../maven/#specifying_explicit_maven_settings

It's perfectly acceptable to specify as many `--rep` arguments as you need.

Note: You should aware of the fact that specifying *any* `--rep` argument on the 
command line overrides *all* of the predefined local repositories. In the case of the 
list above this means that the `modules` repository will be overridden in favor of the 
repository or repositories provided by the `--rep` argument or arguments.

Certain tools need an *destination repository* in which to create or copy modules. 
These tools support the argument `--out` to specify a destination repository, like this:

<!-- lang: none -->
    --out /my/output/repo

Finally, there are two other, more specialized, arguments for specifying repositories:

- `--cacherep` can be used to change the location where downloaded modules will be stored 
  and cached, and
- `--sysrep` can be used to change the location where the system modules needed by Ceylon 
  itself are obtained. You should never need to use this.

But what if you want to specify your repositories to the exclusion of everything else?
What if you want to make sure that *none* of the predefined repositories are searched? 
For that you can use the argument `--no-default-repositories`.

For example, with these options:

<!-- lang: none -->
    --no-default-repositories --rep /the/one/and/only

the tools will *only* look in the path explicitly specified by the `--rep` argument.

Note: This is not entirely true. In fact, the tools always require the `SYSTEM` and `CACHE` 
repositories. We can't do anything about `SYSTEM`, Ceylon needs it to function correctly, 
but if you really want to get rid of even the `CACHE`, you can specify `--offline` along 
with `--no-default-repositories`.

### Repository aliases

In the list above where all the repositories were introduced each of them was given a 
name. This name is the repository's "alias" as defined by Ceylon's configuration. We'll 
get back to that but it's important to explain what those aliases are for: you can use 
an alias everywhere you can use a path or url to a repository by using a plus sign (`+`) 
followed by the alias. So an argument like this:

<!-- lang: none -->
    --out +USER

would mean that we want any modules to be written to the "USER" repository (which, by 
default, points to `$HOME/.ceylon/repo`, as mentioned above).

So far, we've only seen and talked about the predefined aliases like `USER`, `LOCAL`, and 
`SYSTEM`, but it's entirely possible to create your own aliases in the configuration file. 
You can read in detail how to do so [here][Repository configuration].

[Repository configuration]: ../../tool/config/#_repositories_section

## See also

* [Module repositories](..)
* [Repository configuration][]

