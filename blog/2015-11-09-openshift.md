---
title: Running Ceylon on OpenShift
author: St&#233;phane &#201;pardaud
layout: blog
unique_id: blogpage
tab: blog
tags: []
---

This year we released three different ways you can run your Ceylon code on [OpenShift](https://www.openshift.com/features/technologies.html):

- Bare-bones, using the [Ceylon cartridge](https://developers.openshift.com/en/ceylon-overview.html#_using_the_ceylon_cartridge),
- Writing a verticle in Ceylon, using the [Vert.x cartridge](https://developers.openshift.com/en/ceylon-overview.html#_using_the_a_href_vertx_overview_html_vert_x_a_cartridge), or
- Packaging your Ceylon application as a `.war` file and runing it on the WildFly cartridge.

In this post we will see how you can write and publish a bare-bones application on
[OpenShift Online](https://openshift.redhat.com/app/login) using the [OpenShift Ceylon cartridge](https://hub.openshift.com/quickstarts/138-ceylon). 
The Vert.x and WildFly methods will be described in a later blog post.

The OpenShift Ceylon cartridge is for OpenShift V2. Yes I know that's old, as it is now V3, but
the online version of OpenShift is still V2, so it's still relevant. We are working on the
V3 cartridge too, and it should be out soon.

## Writing a bare-bones web application with Ceylon

Let's start by creating a new Ceylon project:

<!-- try: -->
<!-- lang: bash -->
    $ ceylon new hello-world ceylon-blog-openshift
    Enter module name [com.example.helloworld]: openshift.bare  
    Enter module version [1.0.0]: 1
    Would you like to generate Eclipse project files? (y/n) [y]: n
    Would you like to generate an ant build.xml? (y/n) [y]: n
    $ cd ceylon-blog-openshift


Now compile and run it to check that everything is under control:

<!-- try: -->
<!-- lang: bash -->
    $ ceylon compile
    Note: Created module openshift.bare/1
    $ ceylon run openshift.bare/1
    Hello, World!

Now let's make it start an HTTP server, by using the [`ceylon.net`](https://modules.ceylon-lang.org/modules/ceylon.net/1.2.0) module
and adapting its [documentation code sample](https://modules.ceylon-lang.org/repo/1/ceylon/net/1.2.0/module-doc/api/index.html).

First import that module in `source/openshift/bare/module.ceylon`:

<!-- try: -->
    native("jvm")
    module openshift.bare "1" {
      import ceylon.net "1.2.0";
    }

Then use it in `source/openshift/bare/run.ceylon`:

<!-- try: -->
    import ceylon.io { SocketAddress }
    import ceylon.net.http.server { ... }
    
    shared void start(String host, Integer ip){
        //create a HTTP server
        value server = newServer {
            //an endpoint, on the path /hello
            Endpoint {
                path = startsWith("/");
                //handle requests to this path
                service(Request request, Response response)
                        => response.writeString("hello world");
            }
        };
        //start the server
        server.start(SocketAddress(host, ip));
    }
    
    shared void run(){
        start("127.0.0.1",8080);
    }

Let's run it:

<!-- try: -->
<!-- lang: bash -->
    $ ceylon compile
    Note: Created module openshift.bare/1
    $ ceylon run openshift.bare/1
    Starting on 127.0.0.1:8080
    Debug: XNIO version 3.3.0.Final 
    Debug: XNIO NIO Implementation Version 3.3.0.Final 
    Httpd started.

And try it locally at [`http://localhost:8080`](http://localhost:8080), it should show a web page with `hello world`.

## Adapt our application for running on OpenShift

Now let's adapt it to run on OpenShift, where the host name and port are specified by OpenShift,
by using the [`ceylon.openshift`](https://modules.ceylon-lang.org/modules/ceylon.openshift/1.2.0) 
module to see if we are running on OpenShift and if yes, bind to the right address.

First import the OpenShift module in `source/openshift/bare/module.ceylon`:

<!-- try: -->
    native("jvm")
    module openshift.bare "1" {
      import ceylon.net "1.2.0";
      import ceylon.openshift "1.2.0";
    }

And use it in in `source/openshift/bare/run.ceylon`:

<!-- try: -->
    import ceylon.openshift { openshift }
    import ceylon.io { SocketAddress }
    import ceylon.net.http.server { ... }
    
    shared void start(String host, Integer ip){
        //create a HTTP server
        value server = newServer {
            //an endpoint, on the path /hello
            Endpoint {
                path = startsWith("/");
                //handle requests to this path
                service(Request request, Response response)
                        => response.writeString("hello world");
            }
        };
        //start the server
        server.start(SocketAddress(host, ip));
    }
    
    shared void run(){
        if(openshift.running){
            start(openshift.ceylon.ip, openshift.ceylon.port);
        }else{
            start("127.0.0.1",8080);
        }
    }

So now it can run either locally as before, or in OpenShift.

## Configuring our application for the OpenShift Ceylon cartridge

Let's create the required OpenShift structure to tell the OpenShift Ceylon
cartridge how to run our module. We do this by installing the OpenShift 
Ceylon command-line plugin:

<!-- try: -->
<!-- lang: bash -->
    $ ceylon plugin install ceylon.openshift/1.2.0
    Scripts for ceylon.openshift installed in /home/stephane/.ceylon/bin/ceylon.openshift

And now we run it:

<!-- try: -->
<!-- lang: bash -->
    $ ceylon openshift init openshift.bare/1
    Installing file .openshift/config/ceylon.properties: Generated
    ...

Our application is now ready to be run on OpenShift.

## Deploying our application to OpenShift Online

Now, assuming you already have an [OpenShift Online account](https://openshift.redhat.com/app/login), 
and the [`rhc` command installed](https://developers.openshift.com/en/getting-started-overview.html),
you can proceed to create an OpenShift application with the Ceylon cartridge:

<!-- try: -->
<!-- lang: bash -->
    $ rhc create-app --no-git -a test https://raw.github.com/ceylon/openshift-cartridge/master/metadata/manifest.yml
    The cartridge 'https://raw.github.com/ceylon/openshift-cartridge/master/metadata/manifest.yml' will be downloaded and installed
    
    Application Options
    -------------------
    Domain:     fromage
    Cartridges: https://raw.github.com/ceylon/openshift-cartridge/master/metadata/manifest.yml
    Gear Size:  default
    Scaling:    no
    
    Creating application 'test' ... done
    
    
    Waiting for your DNS name to be available ... done
    
    Your application 'test' is now available.
    
      URL:        http://test-fromage.rhcloud.com/
      SSH to:     ...@test-fromage.rhcloud.com
      Git remote: ssh://...@test-fromage.rhcloud.com/~/git/test.git/
    
    Run 'rhc show-app test' for more details about your app.

This created our application on OpenShift Online, and gave us a URL at which we can access it (`http://test-fromage.rhcloud.com/`),
as well as a Git repository where we can push our application (`ssh://...@test-fromage.rhcloud.com/~/git/test.git/`).

Now we just have to turn our application into a Git repository and add the `openshift` remote Url
that `rhc` gave us just above:

<!-- try: -->
<!-- lang: bash -->
    $ git init
    Initialised empty Git repository in /home/stephane/src/java-eclipse/ceylon-blog-openshift/.git/
    $ git remote add openshift ssh://...@test-fromage.rhcloud.com/~/git/test.git/

The Ceylon OpenShift cartridge includes a demo sample app that we can get rid of by forcing
a push of our current application to OpenShift:

<!-- try: -->
<!-- lang: bash -->
    $ git add source .openshift
    $ git commit -m "Initial commit"
    ...
    $ git push -f openshift master
    Counting objects: 23, done.
    Delta compression using up to 16 threads.
    Compressing objects: 100% (18/18), done.
    Writing objects: 100% (23/23), 3.79 KiB | 0 bytes/s, done.
    Total 23 (delta 1), reused 0 (delta 0)
    remote: Stopping Ceylon cart
    remote: Application is already stopped
    remote: Repairing links for 1 deployments
    remote: Building git ref 'master', commit 58ab35c
    remote: 
    remote: Building Ceylon app...
    remote: Compiling every module in /var/lib/openshift/../app-root/runtime/repo//source for the JVM:
    remote: Note: Created module openshift.bare/1
    remote: Ceylon build done.
    remote: Preparing build for deployment
    remote: Deployment id is ...
    remote: Activating deployment
    remote: TODO
    remote: Starting Ceylon cart
    remote: Executing /var/lib/openshift/.../ceylon/usr/ceylon-1.2.0/bin/ceylon
    remote: With params: run   --rep=/var/lib/openshift/.../app-root/runtime/repo/.openshift/config/modules --cacherep=/var/lib/openshift/.../app-root/runtime/repo//cache --rep=http://modules.ceylon-lang.org/repo/1/ --rep=/var/lib/openshift/.../app-root/runtime/repo//modules openshift.bare/1 
    remote: With JAVA_OPTS:  -Dcom.redhat.ceylon.common.tool.terminal.width=9999 -Dceylon.cache.repo=/var/lib/openshift/.../app-root/runtime/repo//cache
    remote: Ceylon started with pid: 350715
    remote: Waiting for http server to boot on 127.5.184.1:8080 ... (1/30)
    remote: Waiting for http server to boot on 127.5.184.1:8080 ... (2/30)
    remote: Waiting for http server to boot on 127.5.184.1:8080 ... (3/30)
    remote: Waiting for http server to boot on 127.5.184.1:8080 ... (4/30)
    remote: Found 127.5.184.1:8080 listening port
    remote: 
    remote: -------------------------
    remote: Git Post-Receive Result: success
    remote: Activation status: success
    remote: Deployment completed with status: success
    To ssh://...@test-fromage.rhcloud.com/~/git/test.git/
       2a29bdf..58ab35c  master -> master

That's it, you can now go and check your application online at `http://test-fromage.rhcloud.com/`.

Congratulations!

Now you can also puglish your code online, at GitHub or elsewhere, and every time you
push your modifications to the `openshift` remote, your application will be restarted
with your changes.

Stay tuned for the Vert.x and WildFly Ceylon OpenShift deployment guides on this blog.
