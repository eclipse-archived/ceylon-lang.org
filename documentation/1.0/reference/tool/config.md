---
layout: reference
title: Ceylon toolset configuration
tab: documentation
unique_id: docspage
author: Tom Bentley
milestone: Milestone 4
doc_root: ../../..
---

# #{page.title}

The ceylon tools use a `git`-like configuration file format for 
configuring their behaviour.

## Usage 

    # Put the cache on the huge disk
    [repository "CACHE"]
    url=/huge-disk/tom/ceylon/repocache
    
    # Define the company repo
    [repository "CompanyRepo"]
    url=http://repo.example.com
    password-alias=company-repo-password
    
    # Append the company repo to the "remote"
    [repositories]
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


## Description

### Config file location


### `[repository]` sections

A `[repository]` section specifies a [module repository](TODO).

[repository]` sections require a name.

Supported properties include:

* `url` - the URL of the repository
* `user` - the user name if the repository requires authentication
* `password` - the plain text password if the repository requires authentication
* `password-alias` - the name of an alias in a `[keystore]` which holds the 
  password, an alternative to using the `password` property.
* `password-keystore` - the name of the `[keystore]` which holds 
  the `password-alias`, if not the default `[keystore]`

There are a few built-in repository names, as follows:

#### `SYSTEM` repository

The system repository holds the modules necessary to use the ceylon tools, for 
example the compiler and language module. By default it it located in the 
`repo` directory of the ceylon installation.

    [repository "SYSTEM"]
    url=system
    
#### `LOCAL` repository

The local repository ...TODO

    [repository "LOCAL"]
    url=system

#### `CACHE` repository

The cache repository contains all modules fetched from remote repositories, 
so they don't have to be downloaded each time they're needed.

    [repository "CACHE"]
    url=system

#### `REMOTE` repository

The remote repository ...TODO

    [repository "REMOTE"]
    url=system

### `[repositories]` section

The `[repositories]` section is used to append or override the standard 
repository lookup order.

    [repositories]
    system=+One
    output=+Two
    cache=+Three
    lookup=+Two
    lookup=+Three
    lookup=+Four
    lookup=foobar
    remote=+Four
    remote=foobar
    
### `[keystore]` section

Although the config file supports specifying passwords in plain text, it also 
supports them being stored in external keystores. The default keystore is 
defined in the `[keystore]` section. Additional named `[keystore]`s can also be 
defined. Each keystore corresponds to a `java.security.KeyStore`.

Supported properties include:

* `file` the name of a keystore file, for those keystores which are file based.
* `store-type` - the `KeyStore` type. Default: `jceks`.
* `store-provider` - the `KeyStore` provider. Default: `SunJCE`.

### `[proxy]` section

<!-- m6 -->


The `[proxy]` section defines a HTTP proxy to use when accessing the network. 

Supported properties include:

* `host` - the hostname of the proxy server
* `port` - the TCP port number of the proxy server. Default: `8080`.
* `user` - the proxy user name, if authenticating to the proxy is required
* `password` - the proxy password, in plain text, or
* `password-alias` - the alias of a `[keystore]` entry which holds the 
   password, an alternative to using the `password` property
* `non-proxy-hosts` - a host name which can be accessed directly, without 
  going via the proxy.


Tools should use the OS's default proxy settings automatically. If you want 
the tools to not use any proxy, you can do us using an empty `[proxy]` section.

## See also



