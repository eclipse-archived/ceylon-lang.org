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

[Ceylon 1.2.2][1.2.2] _&ldquo;Charming But Irrational&rdquo;_ 
is now available for download! This is the second minor update release of
the 1.2 release of the language, command line tools, and IDE.

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
        <td>Eclipse Luna/Mars/Neon</td>
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

After installing, go to `Help > Welcome to Ceylon` to get started.

## Command line tools

This package contains the Ceylon command line compiler for 
Java and JavaScript virtual machines, the documentation 
compiler, the test runner, the language module, the module 
runtimes for the JVM and Node.js, and a suite of additional 
command line tools.

[1.2.2]: /blog/2016/03/11/ceylon-1-2-2/

<table>
    <tr>
        <td>
        <a href="/download/dist/1_2_2" 
           title='Download the Zip archive'
           onClick="javascript: _gaq.push(['_trackPageview', '/download/dist/1_2_2?utm_source=download&amp;utm_medium=web&amp;utm_content=dist&amp;utm_campaign=latestrelease']);">
           <img src="/images/download/package-zip.png" style="vertical-align: middle; float: right; margin-right: 0.5em"/>
        </a>
        </td>
        <td>Zip archive</td>
        <td>All Operating Systems</td>
        <td>
        <a href="/download/dist/1_2_2" 
           title='Download the Zip archive'
           class='bubble-button'
           onClick="javascript: _gaq.push(['_trackPageview', '/download/dist/1_2_2?utm_source=download&amp;utm_medium=web&amp;utm_content=dist&amp;utm_campaign=latestrelease']);">
           DOWNLOAD
        </a>
        </td>
    </tr>
    <tr>
        <td>
        <a href="/download/dist/1_2_2_rpm" 
           title='Download the RPM'
           onClick="javascript: _gaq.push(['_trackPageview', '/download/dist/1_2_2_rpm?utm_source=download&amp;utm_medium=web&amp;utm_content=dist&amp;utm_campaign=latestrelease']);">
           <img src="/images/download/package-fedora.png" style="vertical-align: middle; float: right; margin-right: 0.5em"/>
        </a>
        </td>
        <td>RPM</td>
        <td>Fedora/Red Hat</td>
        <td>
        <a href="/download/dist/1_2_2_rpm" 
           title='Download the RPM'
           class='bubble-button'
           onClick="javascript: _gaq.push(['_trackPageview', '/download/dist/1_2_2_rpm?utm_source=download&amp;utm_medium=web&amp;utm_content=dist&amp;utm_campaign=latestrelease']);">
           DOWNLOAD
        </a>
        </td>
    </tr>
    <tr>
        <td>
        <a href="/download/dist/1_2_2_deb" 
           title='Download the Debian package'
           onClick="javascript: _gaq.push(['_trackPageview', '/download/dist/1_2_2_deb?utm_source=download&amp;utm_medium=web&amp;utm_content=dist&amp;utm_campaign=latestrelease']);">
           <img src="/images/download/package-debian.png" style="vertical-align: middle; float: right; margin-right: 0.5em"/>
        </a>
        </td>
        <td>DEB</td>
        <td>Debian/Ubuntu</td>
        <td>
        <a href="/download/dist/1_2_2_deb" 
           title='Download the Debian package'
           class='bubble-button'
           onClick="javascript: _gaq.push(['_trackPageview', '/download/dist/1_2_2_deb?utm_source=download&amp;utm_medium=web&amp;utm_content=dist&amp;utm_campaign=latestrelease']);">
           DOWNLOAD
        </a>
        </td>
    </tr>
</table>

Instructions for getting started are contained in the file
`README.md` in the root directory of the distribution, or
[right here in GitHub][ceylon-dist readme]. To know what's 
precisely in the release, read our [announcement][1.2.2].

[ceylon-dist readme]: https://github.com/ceylon/ceylon-dist/blob/master/README.md 

### Package managers

Ceylon can also be installed using your favorite package manager.

<ul class="nav nav-tabs">
  <li role="presentation" class="active">
    <a href="#home" aria-controls="sdkman" role="tab" data-toggle="tab"
     ><img src="/images/download/package-sdkman.png" style="vertical-align: middle; margin-right: 0.5em"
      />SDKMAN!</a>
  </li>
  <li role="presentation">
    <a href="#profile" aria-controls="osx" role="tab" data-toggle="tab"
     ><img src="/images/download/package-homebrew.png" style="vertical-align: middle; margin-right: 0.5em"
      />OSX/Homebrew</a>
  </li>
  <li role="presentation">
    <a href="#messages" aria-controls="debian" role="tab" data-toggle="tab"
     ><img src="/images/download/package-debian.png" style="vertical-align: middle; margin-right: 0.5em"
      />Debian/Ubuntu</a>
  </li>
  <li role="presentation">
    <a href="#messages" aria-controls="fedora" role="tab" data-toggle="tab"
     ><img src="/images/download/package-fedora.png" style="vertical-align: middle; margin-right: 0.5em"
      />RHEL/Fedora</a>
  </li>
  <li role="presentation">
    <a href="#messages" aria-controls="arch" role="tab" data-toggle="tab"
     ><img src="/images/download/package-arch.png" srcset="/images/download/package-arch@2x.png 64w" width="32px" style="vertical-align: middle; margin-right: 0.5em"
      />Arch Linux</a>
  </li>
</ul>

<div class="tab-content">
  <div role="tabpanel" class="tab-pane fade in active" id="sdkman">

<p>
Install the Ceylon command line tools via <a href="http://sdkman.io">SDKMAN!</a>:
</p>

<pre data-language="shell"><code class="rainbow">sdk install ceylon</code></pre>
  </div>
  <div role="tabpanel" class="tab-pane fade" id="osx">
<p>
Mac OS X users running the <a href="http://mxcl.github.com/homebrew">Homebrew package manager</a>
can easily install Ceylon:
</p>

<pre data-language="shell"><code class="rainbow">brew update
brew install ceylon</code></pre>

<p>
To upgrade a previous <code>brew</code> installation:
</p>

<pre data-language="shell"><code class="rainbow">brew update
brew upgrade ceylon</code></pre>
  </div>
  <div role="tabpanel" class="tab-pane fade" id="debian">
<p>
You can add our Debian repository to use <code>apt-get</code> to install Ceylon. First add our signing key (our fingerprint
is <code>1E94 7D27 7E60 6F05 B997  4810 40BE A324 5993 5387</code>) and repository:
</p>

<pre data-language="shell"><code class="rainbow">wget -O - https://downloads.ceylon-lang.org/apt/ceylon-debian-repo.gpg.key | sudo apt-key add -
sudo add-apt-repository "deb https://downloads.ceylon-lang.org/apt/ unstable main"
sudo apt-get update</code></pre>

<p>
Once that is done, you can install any version of Ceylon with <code>apt-get</code>:
</p>

<pre data-language="shell"><code class="rainbow">sudo apt-get install ceylon-1.2.2</code></pre>
  </div>
  <div role="tabpanel" class="tab-pane fade" id="fedora">
<p>
You can add our RPM repository to use <code>yum</code> (or <code>dnf</code>) to install Ceylon. 
First add our signing key (our fingerprint
is <code>621E C1A9 6C78 6BE4 583F  3AD3 D4CE B0A4 E024 C8B2</code>) and repository:
</p>

<pre data-language="shell"><code class="rainbow">sudo wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-ceylon https://downloads.ceylon-lang.org/rpm/ceylon-rpm-repo.gpg.key
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-ceylon
# If you're using yum:
sudo yum-config-manager --add-repo https://downloads.ceylon-lang.org/rpm/ceylon.repo
# If you're using dnf:
sudo dnf config-manager --add-repo https://downloads.ceylon-lang.org/rpm/ceylon.repo</code></pre>

<p>
Once that is done, you can install any version of Ceylon with <code>yum</code> (or <code>dnf</code>):
</p>

<pre data-language="shell"><code class="rainbow"># If you're using yum:
sudo yum install ceylon-1.2.2
# If you're using dnf:
sudo dnf install ceylon-1.2.2</code></pre>
  </div>

  <div role="tabpanel" class="tab-pane fade" id="arch">
    <pre data-language="shell"><code class="rainbow"># with an AUR helper, e.&nbsp;g. pacaur:
pacaur -S ceylon
# manually:
git clone https://aur.archlinux.org/ceylon
cd ceylon
makepkg
sudo pacman -U ceylon-1.2.2-1-any.pkg.tar</code></pre>
  </div>

</div>

## SDK

The Ceylon Platform Modules that make up the Ceylon SDK may be 
obtained from [Ceylon Herd](https://herd.ceylon-lang.org). 
You don't need to download the modules yourself, since the
compiler, IDE, or runtime will automatically fetch the modules 
as needed.

## Source code

The source [code](/code) is available from [GitHub](http://ceylon.github.com).

## Looking for nightly builds?

You can download pre-release builds of Ceylon (distribution, SDK, IDEs) on our
[Continuous Integration server](https://ci-ceylon.rhcloud.com/).

## Looking for older releases?

You can download every [previous Ceylon release](/download-archive).

