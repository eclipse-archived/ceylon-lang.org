---
title: Download Ceylon
layout: default
tab: download
unique_id: downloadpage
author: Emmanuel Bernard
priority: 0.95
change_frequency: weekly
---
<div id="banner"><div id="text">Download</div></div>

# #{page.title}

[Ceylon 1.2.1][1.2.1] _&ldquo;Irregular Apocalypse&rdquo;_ 
is now available for download! This is the first minor update release of
the 1.2 release of the language, command line tools, and IDE.

## Command line tools

This package contains the Ceylon command line compiler for 
Java and JavaScript virtual machines, the documentation 
compiler, the test runner, the language module, the module 
runtimes for the JVM and Node.js, and a suite of additional 
command line tools.

[1.2.1]: /blog/2016/02/11/ceylon-1-2-1/

<table>
    <tr>
        <td>
        <a href="/download/dist/1_2_1" 
           title='Download the Zip archive'
           onClick="javascript: _gaq.push(['_trackPageview', '/download/dist/1_2_1?utm_source=download&amp;utm_medium=web&amp;utm_content=dist&amp;utm_campaign=latestrelease']);">
           <img src="/images/download/package-zip.png" style="vertical-align: middle; float: right; margin-right: 0.5em"/>
        </a>
        </td>
        <td>Zip archive</td>
        <td>All Operating Systems</td>
        <td>
        <a href="/download/dist/1_2_1" 
           title='Download the Zip archive'
           class='bubble-button'
           onClick="javascript: _gaq.push(['_trackPageview', '/download/dist/1_2_1?utm_source=download&amp;utm_medium=web&amp;utm_content=dist&amp;utm_campaign=latestrelease']);">
           DOWNLOAD
        </a>
        </td>
    </tr>
    <tr>
        <td>
        <a href="/download/dist/1_2_1_rpm" 
           title='Download the RPM'
           onClick="javascript: _gaq.push(['_trackPageview', '/download/dist/1_2_1_rpm?utm_source=download&amp;utm_medium=web&amp;utm_content=dist&amp;utm_campaign=latestrelease']);">
           <img src="/images/download/package-fedora.png" style="vertical-align: middle; float: right; margin-right: 0.5em"/>
        </a>
        </td>
        <td>RPM</td>
        <td>Fedora/Red Hat</td>
        <td>
        <a href="/download/dist/1_2_1_rpm" 
           title='Download the RPM'
           class='bubble-button'
           onClick="javascript: _gaq.push(['_trackPageview', '/download/dist/1_2_1_rpm?utm_source=download&amp;utm_medium=web&amp;utm_content=dist&amp;utm_campaign=latestrelease']);">
           DOWNLOAD
        </a>
        </td>
    </tr>
    <tr>
        <td>
        <a href="/download/dist/1_2_1_deb" 
           title='Download the Debian package'
           onClick="javascript: _gaq.push(['_trackPageview', '/download/dist/1_2_1_deb?utm_source=download&amp;utm_medium=web&amp;utm_content=dist&amp;utm_campaign=latestrelease']);">
           <img src="/images/download/package-debian.png" style="vertical-align: middle; float: right; margin-right: 0.5em"/>
        </a>
        </td>
        <td>DEB</td>
        <td>Debian/Ubuntu</td>
        <td>
        <a href="/download/dist/1_2_1_deb" 
           title='Download the Debian package'
           class='bubble-button'
           onClick="javascript: _gaq.push(['_trackPageview', '/download/dist/1_2_1_deb?utm_source=download&amp;utm_medium=web&amp;utm_content=dist&amp;utm_campaign=latestrelease']);">
           DOWNLOAD
        </a>
        </td>
    </tr>
</table>

Instructions for getting started are contained in the file
`README.md` in the root directory of the distribution, or
[right here in GitHub][ceylon-dist readme]. To know what's 
precisely in the release, read our [announcement][1.2.1].

[ceylon-dist readme]: https://github.com/ceylon/ceylon-dist/blob/master/README.md 

### SDKMAN! users

You can also install the Ceylon command line tools via [SDKMAN!](http://sdkman.io/):

<!-- lang: none -->
    sdk install ceylon

### OSX users

Mac OS X users running the [Homebrew package manager](http://mxcl.github.com/homebrew/) 
can easily install Ceylon:

<!-- lang: bash -->
    brew update
    brew install ceylon

To upgrade a previous `brew` installation:

<!-- lang: bash -->
    brew update
    brew upgrade ceylon

### Debian/Ubuntu users

You can add our Debian repository to use `apt-get` to install Ceylon. First add our signing key (our fingerprint
is `1E94 7D27 7E60 6F05 B997  4810 40BE A324 5993 5387`) and repository:

<!-- lang: bash -->
    wget -O - https://downloads.ceylon-lang.org/apt/ceylon-debian-repo.gpg.key | sudo apt-key add -
    sudo add-apt-repository "deb https://downloads.ceylon-lang.org/apt/ unstable main"
    sudo apt-get update

Once that is done, you can install any version of Ceylon with `apt-get`:

<!-- lang: bash -->
    sudo apt-get install ceylon-1.2.1

### RHEL/Fedora users

You can add our RPM repository to use `yum` (or `dnf`) to install Ceylon. First add our signing key (our fingerprint
is `621E C1A9 6C78 6BE4 583F  3AD3 D4CE B0A4 E024 C8B2`) and repository:

<!-- lang: bash -->
    sudo wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-ceylon https://downloads.ceylon-lang.org/rpm/ceylon-rpm-repo.gpg.key
    sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-ceylon
    # If you're using yum:
    sudo yum-config-manager --add-repo https://downloads.ceylon-lang.org/rpm/ceylon.repo
    # If you're using dnf:
    sudo dnf config-manager --add-repo https://downloads.ceylon-lang.org/rpm/ceylon.repo

Once that is done, you can install any version of Ceylon with `yum` (or `dnf`):

<!-- lang: bash -->
    # If you're using yum:
    sudo yum install ceylon-1.2.1
    # If you're using dnf:
    sudo dnf install ceylon-1.2.1

## Ceylon IDE

[Ceylon IDE][ide] is a suite of plugins for Eclipse, available 
from our [update site][update site].

[ide]: /documentation/current/ide
[update site]: /documentation/current/ide/install?utm_source=download&utm_medium=web&utm_content=ide-install&utm_campaign=IDE_latestrelease

<table>
    <tr>
        <td>
        <a href="/documentation/current/ide/install" 
           title='Install the IDE'
           onClick="javascript: _gaq.push(['_trackPageview', '/documentation/current/ide/install?utm_source=download&amp;utm_medium=web&amp;utm_content=dist&amp;utm_campaign=latestrelease']);">
           <img src="/images/download/eclipse-ide.png" style="vertical-align: middle; float: right; margin-right: 0.5em"/>
        </a>
        </td>
        <td>Ceylon IDE</td>
        <td>Eclipse Luna/Mars</td>
        <td>
        <a href="/documentation/current/ide/install" 
           title='Install the IDE'
           class='bubble-button'
           onClick="javascript: _gaq.push(['_trackPageview', '/documentation/current/ide/install?utm_source=download&amp;utm_medium=web&amp;utm_content=dist&amp;utm_campaign=latestrelease']);">
           FOLLOW THESE INSTRUCTIONS
        </a>
        </td>
    </tr>
</table>

<!--
<table>
    <tr>
        <td>
        <a href='http://marketplace.eclipse.org/marketplace-client-intro?mpc_install=185799' 
          title='Drag and drop into a running Eclipse Luna workspace to install Ceylon IDE'>
          <img src='http://marketplace.eclipse.org/misc/installbutton.png' style="vertical-align: middle; float: right; margin-right: 0.5em"/>
        </a>
        </td>
        <td>Ceylon IDE</td>
        <td>Eclipse Luna</td>
        <td>
        <a href='http://marketplace.eclipse.org/marketplace-client-intro?mpc_install=185799' 
           title='Drag and drop into a running Eclipse Indigo workspace to install Ceylon IDE' 
           style='font-weight:bold;text-decoration:none'> 
          drag and drop into a running Eclipse workspace
        </a>
        </td>
    </tr>
</table>
-->

After installing, go to `Help > Welcome to Ceylon` to get started.

## SDK

The Ceylon Platform Modules that make up the Ceylon SDK may be 
obtained from [Ceylon Herd](https://herd.ceylon-lang.org). 
You don't need to download the modules yourself, since the
compiler, IDE, or runtime will automatically fetch the modules 
as needed.

## Source code

The source [code](/code) is available from [GitHub](http://ceylon.github.com).

## Looking for older releases?

You can download every [previous Ceylon release](/download-archive).
