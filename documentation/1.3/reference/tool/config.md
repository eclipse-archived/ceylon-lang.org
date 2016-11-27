---
layout: reference13
title_md: Ceylon toolset configuration
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

The `ceylon` tools use a `git`-like configuration file format for configuring 
their behavior.

## Example configuration file 

<!-- lang:none -->
    # Put the cache on the huge disk
    [repository "CACHE"]
    url=/huge-disk/tom/ceylon/repocache
    
    # Define the company repo
    [repository "CompanyRepo"]
    url=http://repo.example.com
    password-alias=company-repo-password
    
    # Append the company repo to the "remote"
    [repositories]
    global=/usr/local/ceylon/repo
    remote=+CompanyRepo

    # define a keystore to put my passwords in
    [keystore]
    file=/home/tom/toms-keys
    
    # define a proxy for accessing the network
    [proxy]
    host=webproxy
    port=8000
    user=tom
    password-alias=proxy-password


## Configuration file location

There are several configuration files that can affect the configuration of the 
Ceylon tool chain. They go from least specific at the level of the system itself 
which affect all projects and all users to most specific at the level of a single 
project affecting only that project.

The first configuration file that gets read is the one at the system level which:
 
- on Linux and Mac OS is `/etc/ceylon/config`, and 
- on (modern) Windows something like `C:\ProgramData\ceylon\config`.

After that comes the user's own configuration file which holds those values which 
only apply to that specific user:

- on Linux it is `/home/<username>/.ceylon/config`,
- on Mac OS it is `/Users/<username>/.ceylon/config`, and 
- on (modern) Windows it is something like `C:\Users\<username>\.ceylon\config`.

Finally comes the most specific configuration file which is located in a subfolder 
of the current working directory: `.ceylon/config`. This means it depends on the 
working directory where you are executing the `ceylon` command! (When using an IDE 
the current working directory is the project folder itself.)

Now in reality it's a bit more complex than this, because before reading that local 
file Ceylon will first see if a configuration file exists in the `.ceylon` folder of 
the *parent* folder of the current working directory. And before reading *that* one 
it will see if one exists in *its* parent folder, etc, etc, all the way up to the 
root of the file system (it will ignore the user's and system configuration files 
if it happens to encounter them while traversing the file system). This provides us 
with the possibility to set configuration options for a group of projects.

## Configuration file structure

### Basics

A configuration file consists of *sections* with *key/value pairs* and *comments*.
A *section* consists of a name surrounded by square brackets:

<!-- lang:none -->
    [examplesection]
    
These names must start with a letter and for the rest can only contain letters 
and digits (and periods as we'll see later, but they are not part of the name).

We can also add comments, either on their own line or at the end of an existing 
line:

<!-- lang:none -->
    # A comment on its own line
    [examplesection] # Another comment

Within sections we can define key/value pairs, each on their own line:

<!-- lang:none -->
    [examplesection]
    some-setting=300
    

### More about keys

Key names can only contain letters, digits and dashes. To unambiguously refer to 
a certain key in a certain section you can use the "complete name" which for the 
above setting is `example-section.some-setting`. Its value is `300`. In this form all 
leading and trailing spaces and tabs are ignored (as are comments), so the 
following is exactly the same as the above:

<!-- lang:none -->
    [ example-section ]
    some-setting  =  300 # Some comment

Key names and main section names can never contain spaces or tabs, but values 
can. In those cases that you need to specify leading or trailing spaces and tabs 
as part of the value you need to *quote* the value like this:

<!-- lang:none -->
    [example-section]
    text=" An example text "

Spaces and tabs within the quotes are part of the value, any spaces and tabs 
outside them are ignored.

Sometimes it is necessary to specify values that span multiple lines, the easiest 
way to do that is like this:

<!-- lang:none -->
    [lines]
    long-text-unquoted=A very\
    very\
    long line.
    long-text-quoted= "Another very\
    very\
    long line."

And the final item on the topic of values are *escapes*, sometimes it's necessary 
to be able to specify special character that cannot (easily) be entered in another 
way:

<!-- lang:none -->
    [escapes]
    escape1=\t # A single TAB character
    escape2=\n # A single NEWLINE character
    escape3="\"" # A double-quote character, so you can use them in quoted values
    escape4=\\ # A single backslash, so you can use backslashes in values
    
NB: using escapes the above `[lines]` example could be rewritten like:

<!-- lang:none -->
    [lines]
    long-text-unquoted=A very\nvery\nlong line.
    long-text-quoted= "Another very\nvery\nlong line."

And that would be exactly the same. It's up to you to decide what you prefer.

### More about sections

Now back to sections. For complex configurations it is possible to divide sections
into sub-sections (and sub-sub-sections or sub-sub-sub-etc if necessary). This can 
be done in two different ways, either quoted or unquoted:

<!-- lang:none -->
    [examplesection "Sub section 1"]
    some-setting=300
    
<!-- lang:none -->
    [examplesection "Sub section 2"]
    some-setting=400

<!-- lang:none -->
    [examplesection.subsection1]
    some-setting=100
    
<!-- lang:none -->
    [examplesection.subsection2]
    some-setting=200
    
In the quoted version the name sub-section can contain almost any characters you 
want and is meant to give more human-friendly names, in the unquoted version the 
name of the sub-section must adhere to the same rules as for the main section 
name (starts with a letter and only letters and digits after that) and names are 
separated by a period.

## Configuration file contents

### `[defaults]` section

The `[defaults]` section is used to change the default behaviour of the ceylon
tool chain. Recognized settings include:

- `encoding`:
The character set (e.g. `UTF-8`) to use when reading source files.
If not specified, the default file encoding for the platform is assumed.

- `offline`:
Prevents the tool chains from trying to download modules from remote repositories. 
Accepts `yes`, `true` (equivalent to `yes`), `no` or `false` (equivalent to `no`). 
Defaults to `no` (`false`).

- `timeout`:
The number of seconds to wait while connecting to a remote host before giving up.
Platform specific default.

- `overrides`:
A file specifying [module overrides](../../repository/overrides/).

### `[compiler]` section

[`ceylon compile`]: ../ceylon/subcommands/ceylon-compile.html
[`ceylon compile-js`]: ../ceylon/subcommands/ceylon-compile-js.html
[`ceylon doc`]: ../ceylon/subcommands/ceylon-doc.html
[`ceylon src`]: ../ceylon/subcommands/ceylon-src.html
[`ceylon plugin`]: ../ceylon/subcommands/ceylon-plugin.html

The `[compiler]` section is mainly used to change the default behaviour of the 
compile tool. The possible settings include:

- `source`:
Equivalent to supplying `--source` on the command line. 
It takes a path to a folder containing sources. 
May be specified multiple times.

- `resource`:
Equivalent to supplying `--resource` on the command line.
It takes a path to a folder containing resources.
May be specified multiple times.

**Note:** although it appears in the `[compiler]` section these settings actually 
affect *any* tools that take `--source` or `--resource` options. If a tool normally 
takes only a single of these options the first in the list will be used.

- `module`:
Equivalent to supplying a `module` name on the command line.
May be specified multiple times.

- `resourceroot`: 
Equivalent to supplying the 
[`--resource-root`](../ceylon/subcommands/ceylon-compile.html#option--resource-root) 
option to [`ceylon compile`][], [`ceylon compile-js`][] or [`ceylon src`][].

- `suppresswarning`: 
Equivalent to supplying the 
[`--suppress-warning`](../ceylon/subcommands/ceylon-compile.html#option--suppress-warning) 
option to [`ceylon compile`][].

- `noosgi`:
Equivalent to supplying the 
[`--no-osgi`](../ceylon/subcommands/ceylon-compile.html#option--no-osgi) 
option to [`ceylon compile`][].

- `osgiprovidedbundles`:
Equivalent to supplying the 
[`--osgi-provided-bundles`](../ceylon/subcommands/ceylon-compile.html#option--osgi-provided-bundles) 
option to [`ceylon compile`][].

- `nopom`:
Equivalent to supplying the 
[`--no-pom`](../ceylon/subcommands/ceylon-compile.html#option--no-pom) 
option to [`ceylon compile`][].

- `generatemoduleinfo`:
Equivalent to supplying the 
[`--generate-module-info`](../ceylon/subcommands/ceylon-compile.html#option--generate-module-info) 
option to [`ceylon compile`][].

- `pack200`:
Equivalent to supplying the 
[`--pack200`](../ceylon/subcommands/ceylon-compile.html#option--pack200) 
option to [`ceylon compile`][].

- `progress`:
Equivalent to supplying the 
[`--progress`](../ceylon/subcommands/ceylon-compile.html#option--progress) 
option to [`ceylon compile`][].

- `jdkprovider`:
Equivalent to supplying the 
[`--jdk-provider`](../ceylon/subcommands/ceylon-compile.html#option--jdk-provider) 
option to [`ceylon compile`][].

- `javac`:
Equivalent to supplying the 
[`--javac`](../ceylon/subcommands/ceylon-compile.html#option--javac) 
option to [`ceylon compile`][].

- `doc`:
Equivalent to supplying the 
[`--doc`](../ceylon/subcommands/ceylon-doc.html#option--doc) 
option to [`ceylon doc`][] or [`ceylon src`][].

- `script`:
Equivalent to supplying the 
[`--script`](../ceylon/subcommands/ceylon-src.html#option--script) 
option to [`ceylon src`][] or [`ceylon plugin`][].

### `[compiler.BACKEND]` section

These are a special sections for the compile tool that are specific to each 
backend. So there is a `compiler.jvm` section for the Java backend and a 
`[compiler.js]` section for the JavaScript backend and so forth. The available 
option for these sections is: `module` and it has the same meaning as above.

### `[runtool]` section

[`ceylon run`]: ../ceylon/subcommands/ceylon-run.html
[`ceylon run-js`]: ../ceylon/subcommands/ceylon-run-js.html

- `compile`:
Equivalent to supplying the 
[`--compile`](../ceylon/subcommands/ceylon-run.html#option--compile) 
option to [`ceylon run`][] or [`ceylon run-js`][].

- `module`:
Equivalent to supplying the `module` argument to [`ceylon run`][] or 
[`ceylon run-js`][].

- `run`:
Equivalent to supplying the 
[`--run`](../ceylon/subcommands/ceylon-run.html#option--run) 
option to [`ceylon run`][] or [`ceylon run-js`][].
Only taken into account when the `module` option is also specified, otherwise
ignored.

- `arg`:
Equivalent to supplying arguments to the Ceylon application being run using
[`ceylon run`][] or [`ceylon run-js`][].
Can be specified multiple times. 
Only taken into account when the `module` option is also specified, otherwise 
ignored.

### `[runtool.BACKEND]` section

These are a special sections for the run tool that are specific to each backend.
So there is a `runtool.jvm` section for the Java backend and a `[runtool.js]` section 
for the JavaScript backend and so forth. The available options for these sections 
are: `module`, `run` and `arg` and they have the same meaning as above.

### `[testtool]` section

[`ceylon test`]: ../ceylon/subcommands/ceylon-test.html
[`ceylon test-js`]: ../ceylon/subcommands/ceylon-test-js.html

- `compile`:
Equivalent to supplying the 
[`--compile`](../ceylon/subcommands/ceylon-test.html#option--compile) 
option to [`ceylon test`][] or [`ceylon test-js`][].

### `[repositories]` section

Ceylon uses a set of local and remote repositories for its modules. The order 
and significance of the lookup (which is fixed) is:

- `system` &mdash; Essential system modules
- `cache`  &mdash; A cache of modules that were previously downloaded from remote 
  repositories
- `output` &mdash; Where the compiler stores newly created modules
- `lookup` &mdash; Other local repositories
- `global` &mdash; Predefined user and system global repositories
- `remote` &mdash; User defined remote repositories
- `other`  &mdash; Predefined remote repositories

The `[repositories]` section can be used to override the default values for those
entries thereby changing or extending the lookup order. Take a look at the 
following example:

<!-- lang:none -->
    [repositories]
    output=./output # Store new modules in the local `output` folder
    cache=/huge-disk/tom/ceylon/repocache # Store the cached modules on a bigger disk
    lookup=./modules
    lookup=./extra-modules
    lookup=/usr/local/ceylon/even-more-modules
    remote=http://ceylon.example.com # An external site with Ceylon modules

First of all, the values for `ouput` and `cache` (as well as `system`, but you should
normally never try overriding it) can only be specified once, while the others 
(`lookup`, `global` and `remote`) can be specified multiple times, Ceylon will try them 
one by one in the order you specify in this list.

NB: When we say "in the order you specify" we refer to the ones with the same key 
name, so if you add several `remote` repositories they will be tried in the order 
you specify, but you cannot change the main ordering: `lookup` repositories will 
always be  tried before `global`, which will always be tried before `remote`.

Now looking at `lookup` we see that it's specified 3 times, but one of those lines 
contains a path to the local `modules` folder, which (as we will see later) is 
actually already part of the default `lookup` list. So why is it specified here again? 
Well, it is important to realize that in the configuration file we can only *override* 
existing values, we cannot change them or append to them, so when overriding a value 
like `lookup` without changing the default behavior we must take care to include 
existing values.

The `remote` entry doesn't have any default value, so it can be easily used without 
having to worry about pre-existing values. It's specifically meant to add extra 
(normally remote) repositories that will be tried after all other options have been 
exhausted.

The `other` entry isn't mentioned in the above example because in general it is 
advisable to leave it alone, it contains a list of predefined repositories, among 
which is the main Ceylon repository itself that contains most of the interesting 
3rd party modules. You should only need to override it if for some reason you do 
*not* want the default behaviour.


### `[repository]` sections

So far when specifying respositories we have been using simple files system paths and 
HTTP URLs, but this might not be enough in certain cases. You might want to refer to a 
complex URL from the command line for example without having to type it each time. Or, 
in the case of a remote output repository, it might be necessary to authenticate before 
you will be allowed to push anything to that server.

For that porpose we can create a `[repository]` definition. Because all respository 
definitions are actually sub-sections of `[repository]` they require a name. An example 
could be:

<!-- lang:none -->
    [repository "CompanyRepo"]
    url=http://ceylon.example.com
    user=fubar
    password=secret!

Supported properties include:

- `url` &mdash; the URL of the repository. May be:

  - a remote URL like `http://repo.example.com` and `maven:`, or
  - a reference to a folder on the local file system, either absolute like 
    `/huge-disk/tom/ceylon/repocache`, or relative to the project folder like 
    `modules` or `./my-modules`.
  
  This property is required.
- `user` &mdash; the user name if the repository requires authentication
- `password` &mdash; the plain text password if the repository allows plain text 
  authentication
- `password-alias` &mdash; the name of an alias in a `[keystore]` which holds the password, 
  an alternative to using the `password` property.
- `password-keystore` &mdash; the name of the `[keystore]` which holds the `password-alias`, 
  or, if not, the default `[keystore]`

Using `[repository]` definitions like the above you can now refer to it from within the
`[repositories]` section like this (pay attention to the `+` sign which is required):

<!-- lang:none -->
    [repositories]
    remote=+CompanyRepo

You can now also refer to this repository from the command line, for example when pushing
a compiled module to the secure company repository:

<!-- lang:bash -->
    $ ceylon compile --out +CompanyRepo com.example.mymodule

There are a few built-in repository names, as follows:


#### `SYSTEM` repository

The system repository holds the modules necessary to use the ceylon tools, for example, 
the compiler and language module. By default it is located in the `repo` directory of 
the ceylon installation.

<!-- lang:none -->
    [repository "SYSTEM"]
    url=CEYLON_HOME/repo


#### `CACHE` repository

The cache repository contains all modules fetched from remote repositories, so they 
don't have to be downloaded each time they're needed. By default it is located in the 
`.ceylon/cache` folder located in the user's home directory.

<!-- lang:none -->
    [repository "CACHE"]
    url=~/.ceylon/cache


#### `LOCAL` repository

The local repository is where modules are stored that are created by compiling local
projects. By default it is specified as the folder `modules` relative to the current
project folder.

<!-- lang:none -->
    [repository "LOCAL"]
    url=./modules


#### `USER` repository

The user repository is where a user can store modules that will be available to them
for execution regardless of the current folder the user runs the program. By default
it is located in the `.ceylon/repo` folder located in the user's home directory.
This can be overridden by setting the `ceylon.config` system property to point to
the file that should be used.

<!-- lang:none -->
    [repository "USER"]
    url=~/.ceylon/repo


#### `REMOTE` repository

The remote repository points to the official Ceylon module repository ("The Herd")
that contains all the official Ceylon SDK modules and all other freely available
3rd party modules. By default this is `https://herd.ceylon-lang.org`.

<!-- lang:none -->
    [repository "REMOTE"]
    url=https://herd.ceylon-lang.org


#### `MAVEN` repository

The remote repository points to the official Maven module repository that contains 
so much of the Java ecosystem's finest contributions. By default this is `maven:`.

<!-- lang:none -->
    [repository "MAVEN"]
    url=maven:


#### The `[repositories]` section revisited

*This paragraph doesn't really contain any information necessary to be able to work
with the Ceylon tool chain, but it might be interesting for completeness sake.*

Looking at the above list we now have sufficient information to be able to know 
what the default `[repositories]` section would look like:

<!-- lang:none -->
    [repositories]
    system=+SYSTEM
    cache=+CACHE
    output=+LOCAL
    lookup=+LOCAL
    global=+USER
    other=+REMOTE
    other=+MAVEN

This also means that if you define your own `[repository]` section with one of the
above predefined names you will *override* the default location for that 
repository. (So in fact there are two ways to override predefined repositories.)


### `[keystore]` section

Although the config file supports specifying passwords in plain text, it also 
supports them being stored in external keystores. The default keystore is defined 
in the `[keystore]` section. Additional named `[keystore]`s can also be defined. Each 
keystore corresponds to a `java.security.KeyStore`.

Supported properties include:

- `file` &mdash; the name of a keystore file, for those keystores which are file 
  based.
- `store-type` &mdash; the `KeyStore` type. Default: `jceks`.
- `store-provider` &mdash; the `KeyStore` provider. Default: `SunJCE`.


### `[proxy]` section

The `[proxy]` section defines a HTTP proxy to use when accessing the network. 

Supported properties include:

- `host` &mdash; the hostname of the proxy server
- `port` &mdash; the TCP port number of the proxy server. Default: `8080`.
- `user` &mdash; the proxy user name, if authenticating to the proxy is required
- `password` &mdash; the proxy password, in plain text, or
- `password-alias` &mdash; the alias of a `[keystore]` entry which holds the 
  password, an alternative to using the `password` property
- `non-proxy-hosts` &mdash; a host name which can be accessed directly, without 
  going via the proxy.

Tools should use the OS's default proxy settings automatically. If you want the 
tools to not use any proxy, you can do us using an empty `[proxy]` section.

