---
title: Download Ceylon
layout: default
tab: download
unique_id: downloadpage
author: Emmanuel Bernard
---
<div id="banner"><div id="text">Download</div></div>

# #{page.title}

[Ceylon 1.1.0][1.1.0] _&ldquo;Ultimate Ship The Second&rdquo;_ is now 
available for download! This is the second production-ready release 
of the language, command line tools, and IDE.

## Command line tools

This package contains the Ceylon command line compiler for Java and
JavaScript virtual machines, the documentation compiler, the language 
module, and the module runtime.

[1.1.0]:/blog/2014/10/09/ceylon-1

<table>
    <tr>
        <td>
        <a href="/download/dist/1_1_0" 
           title='Download the Zip archive'
           onClick="javascript: _gaq.push(['_trackPageview', '/download/dist/1_1_0?utm_source=download&amp;utm_medium=web&amp;utm_content=dist&amp;utm_campaign=latestrelease']);">
           <img src="/images/download/package-zip.png" style="vertical-align: middle; float: right; margin-right: 0.5em"/>
        </a>
        </td>
        <td>Zip archive</td>
        <td>All Operating Systems</td>
        <td>
        <a href="/download/dist/1_1_0" 
           title='Download the Zip archive'
           class='bubble-button'
           onClick="javascript: _gaq.push(['_trackPageview', '/download/dist/1_1_0?utm_source=download&amp;utm_medium=web&amp;utm_content=dist&amp;utm_campaign=latestrelease']);">
           DOWNLOAD
        </a>
        </td>
    </tr>
    <tr>
        <td>
        <a href="/download/dist/1_1_0_rpm" 
           title='Download the RPM'
           onClick="javascript: _gaq.push(['_trackPageview', '/download/dist/1_1_0_rpm?utm_source=download&amp;utm_medium=web&amp;utm_content=dist&amp;utm_campaign=latestrelease']);">
           <img src="/images/download/package-fedora.png" style="vertical-align: middle; float: right; margin-right: 0.5em"/>
        </a>
        </td>
        <td>RPM</td>
        <td>Fedora/Red Hat</td>
        <td>
        <a href="/download/dist/1_1_0_rpm" 
           title='Download the RPM'
           class='bubble-button'
           onClick="javascript: _gaq.push(['_trackPageview', '/download/dist/1_1_0_rpm?utm_source=download&amp;utm_medium=web&amp;utm_content=dist&amp;utm_campaign=latestrelease']);">
           DOWNLOAD
        </a>
        </td>
    </tr>
    <tr>
        <td>
        <a href="/download/dist/1_1_0_deb" 
           title='Download the Debian package'
           onClick="javascript: _gaq.push(['_trackPageview', '/download/dist/1_1_0_deb?utm_source=download&amp;utm_medium=web&amp;utm_content=dist&amp;utm_campaign=latestrelease']);">
           <img src="/images/download/package-debian.png" style="vertical-align: middle; float: right; margin-right: 0.5em"/>
        </a>
        </td>
        <td>DEB</td>
        <td>Debian/Ubuntu</td>
        <td>
        <a href="/download/dist/1_1_0_deb" 
           title='Download the Debian package'
           class='bubble-button'
           onClick="javascript: _gaq.push(['_trackPageview', '/download/dist/1_1_0_deb?utm_source=download&amp;utm_medium=web&amp;utm_content=dist&amp;utm_campaign=latestrelease']);">
           DOWNLOAD
        </a>
        </td>
    </tr>
</table>

Mac OS X users running the [Homebrew package manager](http://mxcl.github.com/homebrew/) 
can easily install Ceylon:

<!-- lang: none -->
    brew update
    brew install ceylon

To upgrade a previous `brew` installation:

<!-- lang: none -->
    brew update
    brew upgrade ceylon

Instructions for getting started are contained in the file
`README.md` in the root directory of the distribution, or
[right here in GitHub][ceylon-dist readme]. To know what's 
precisely in the release, read our [announcement][1.0.0].

[ceylon-dist readme]: https://github.com/ceylon/ceylon-dist/blob/master/README.md 


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
        <td>Eclipse Kepler/Juno/Luna</td>
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
obtained from [Ceylon Herd](http://modules.ceylon-lang.org). 
You don't need to download the modules yourself, since the
compiler, IDE, or runtime will automatically fetch the modules 
as needed.

## Source code

The source [code](/code) is available from [GitHub](http://ceylon.github.com).

## Looking for older releases?

You can download every [previous Ceylon release](/download-archive).
