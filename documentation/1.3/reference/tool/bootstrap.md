---
layout: reference13
title_md: Ceylon Bootstrap
tab: documentation
unique_id: docspage
author: Tako Schotanus
doc_root: ../../..
---

[ceylon bootstrap]: ../../tool/ceylon/subcommands/ceylon-bootstrap.html

# #{page.title_md}

The Ceylon Bootstrap is a script that can be copied to a Ceylon project folder
that, when run by a user, will act in every way as the regular `ceylon` command
but without having to first go through the process of downloading and installing
a Ceylon distribution.

On first execution of the script it will detect that no prior version exists
and will then proceed to download and install the required Ceylon distribution
into the user's home directory (by default, see below how this can be overridden).

## The `ceylon bootstrap` command

To prepare a Ceylon project for bootstrapping simply run the [ceylon bootstrap][]
command in the project's root directory:

<!-- lang:none -->
    $ ceylon bootstrap

This will create 2 scripts: `ceylonb` for the unices and `ceylonb.bat` for Windows.
(It will also generate 2 support files in `./.ceylon/bootstrap/`)

Those two files act in every way as the normal `ceylon` versions that you get with
a Ceylon distribution (in fact they are exactly the same), so you can simply do things
like `./ceylonb compile my.module`.

The difference lies in the fact that if you don't have Ceylon installed the script
will first download it and install it in your Ceylon user folder (in `~/.ceylon/dists/`
in fact).

Which version it downloads and installs depends on the Ceylon version that was used
to run the `ceylon bootstrap` command. Or you can pass a specific version (or even a URL)
to the bootstrap command like this:

<!-- lang:none -->
    $ ceylon bootstrap 1.2.0

Running `./ceylonb` will then download the 1.2.0 Ceylon distribution the first time it's called.

*NB: Using the bootstrap script means bypassing any Ceylon versions you might have installed
on your system by other means. So even if you already installed the required version using your
system's package manager, or brew, or sdkman, the bootstrap script will *still* download
its own version**

Instead of a version it's also possible to pass a URL to the bootstrap command, for
example a URL pointing to a nightly build. In fact when you pass a version number
what really happens is that a URL is formed by taking `https://downloads.ceylon-lang.org/cli/`
and adding `ceylon-YOURVERSION.zip` to it.

## The `.properties` file

So how does `ceylonb` know which distribution to download?

Well this information is stored in the `./.ceylon/bootstrap/ceylon-bootstrap.properties`
file found in the same directory as the `ceylonb` script.

It's a standard Java properties file and should contain at least the following line:

<!-- lang:none -->
    distribution=https://downloads.ceylon-lang.org/cli/ceylon-1.2.0.zip

(where the actual URL can be different of course)

The script will check if the given distribution is already available and download
and install it if not.

*NB: The `distribution` can also be a relative path to a distribution zip found on
the local file system. The path is relative to the folder where the `ceylon-bootstrap.properties`
file is found. This can be useful if you want to distribute Ceylon along with your project.*

By default distributions get installed to `~/.ceylon/dists` but you can override
this with the `installation` option in the properties file, like this:

<!-- lang:none -->
    installation=../dists

The installation path is always relative to the folder where the `ceylon-bootstrap.properties`
file is found. In this example any distributions would get installed to the `./.ceylon/dists/`
folder inside the Ceylon project. This is a very useful option when dealing with CI servers
where writing things to the user's home directory is not allowed.

*NB: The default installation path can also changed by setting either the
environment variable `CEYLON_BOOTSTRAP_DISTS` to the required path.
The `ceylon.bootstrap.dists` System property can be used for the same purpose.*

*A similar option exists for overriding where the bootstrap looks for the
`.properties` file: use the `CEYLON_BOOTSTRAP_PROPERTIES` environment
variable or the `ceylon.bootstrap.properties` System property to point
to the properties file that should be loaded.*

The final option that can be specified in the properties file is `sha256sum`.
If specified it should contains the SHA-256 sum of the distribution archive:

<!-- lang:none -->
    sha256sum=2e3b50e3e80ea3a356d0d62a2cff5b59104c591aa06387e55cd34a10d52c2919

If the archive's sum doesn't match what's specified in the properties the
distribution will not be installed and the command execution will fail.

## The `ceylon` command itself

This is all implemented as part of the normal Ceylon startup and launch sequence.
Because of that the normal `ceylon` command now also supports specifying the
distribution that should be used to run a command. You can do it like this:

<!-- lang:none -->
    ceylon --distribution=1.2.0 compile my.module

Another example would be (having 1.2.2 installed by default):

<!-- lang:none -->
    $ ceylon --version
    ceylon version 1.2.2 da8272d (Charming But Irrational)

and now compare this to:

<!-- lang:none -->
    $ ceylon --distribution=1.0.0 --version
    ceylon version 1.0.0 (No More Mr Nice Guy)

Which, like the `ceylonb` script, will do a one-time download of the 1.1.0 distribution
before passing execution to it.

## See also

* [ceylon bootstrap][]

