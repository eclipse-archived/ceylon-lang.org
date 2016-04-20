---
title: Ceylon on mobile devices
author: St&#233;phane &#201;pardaud
layout: blog
unique_id: blogpage
tab: blog
tags: [interop, mobile, android, ios, modularity]
---

Ceylon already runs on the JVM, whether bare-bones, via JBoss Modules, Vert.x, Java EE Servlet
containers such as WildFly, or OSGi containers, as well as on JavaScript VMs such as Node.js
and the browser. But today we're going to explain how to run Ceylon on mobile devices, not just
in the browser (though it does play a part in it), but as applications, via Apache Cordova.

[Apache Cordova](https://cordova.apache.org) allows you to write applications for every mobile
platform, including Android and iOS, using nothing but HTML, CSS and JavaScript. Since Ceylon
compiles to JavaScript this is perfect as it allows us to run our Ceylon applications on iOS,
via the JavaScript compiler backend.

# Writing your Ceylon Cordova application

## Installing Apache Cordova

First, [install Apache Cordova](https://cordova.apache.org/#getstarted) and add two platforms.
I haven't been able to test the iOS platform since it requires an OSX platform to build and
and iOS device to test, and I lack both, so I will explain how to package for Android and the
browser, and let you guys try it out for iOS, but I have enough faith in Apache Cordova that
it will Just Work™.

<!-- try: -->
<!-- lang: bash -->
    # Install npm, the Node.js package manager
    $ sudo apt-get install npm
    # Then install Apache Cordova
    $ npm install cordova

Small note: for me this installed things in `./node_modules/cordova` and the Apache Cordova
command in `./node_modules/cordova/bin/cordova`, so adapt your path as you must.

<!-- try: -->
<!-- lang: bash -->
    # Create your application
    $ cordova create ceylon-cordova-demo
    $ cd ceylon-cordova-demo
    # Now add the browser and Android platforms
    $ cordova platform add browser
    $ cordova platform add android

At this point you have your application ready to be checked in your browser:

<!-- try: -->
<!-- lang: bash -->
    $ cordova platform run browser

Or in an Android emulator, provided you have downloaded the Android SDK already:

<!-- try: -->
<!-- lang: bash -->
    $ ANDROID_HOME=.../Android/Sdk cordova platform build android
    $ ANDROID_HOME=.../Android/Sdk cordova platform run android

## Getting a little side-tracked about styling

Writing an application using just HTML and CSS means you have to make some effort for
it to look good, and instead I decided to delegate to use [Polymer](https://www.polymer-project.org)
so that my application would have the look and feel of 
[Android Material Design](https://www.google.com/design/spec/material-design/introduction.html) applications
to feel even more like a native application on Android. No doubt a similar look and feel exists for iOS.

So let's download [Polymer](https://www.polymer-project.org/1.0/docs/start/getting-the-code.html) in our
application's HTML sources:

<!-- try: -->
<!-- lang: bash -->
    $ npm install bower
    $ cd www
    $ bower init
    # At this point just hit enter/Yes/No until it's set up 
    $ bower install --save Polymer/polymer
    $ bower install --save Polymerelements/paper-item

And now edit `www/index.html` to use Polymer:

<!-- try: -->
<!-- lang: html -->
    <script src="bower_components/webcomponentsjs/webcomponents.js"></script>
    <link rel="import" href="bower_components/paper-item/paper-item.html">
    <link rel="import" href="bower_components/paper-item/paper-item-body.html">

You should also remove the default CSS:

<!-- try: -->
<!-- lang: html -->
    <link rel="stylesheet" type="text/css" href="css/index.css">

## Getting require.js and jQuery

Ceylon compiles to JavaScript modules by way of [require.js](http://requirejs.org), so we're going to
have to download it too:

<!-- try: -->
<!-- lang: bash -->
    $ cd www/js
    $ wget http://requirejs.org/docs/release/2.2.0/minified/require.js

Our Ceylon demo will use `jQuery` to add elements to the HTML page, so we also need it:

<!-- try: -->
<!-- lang: bash -->
    $ cd www
    $ bower install --save jquery

Now edit `www/index.html` to use both:

<!-- try: -->
<!-- lang: html -->
    <script type="text/javascript" src="js/require.js"></script>
    <script src="bower_components/jquery/dist/jquery.js"></script>

## Writing the Ceylon application

We're going to write a trivial application that queries Ceylon Herd for the list of modules, to display them
in a list.

Let's start by creating a Ceylon module in `source/cordova/demo/module.ceylon`:

<!-- try: -->
    module cordova.demo "1.0.0" {
        import ceylon.json "1.2.3";
    }

And our application's main method in `source/cordova/demo/run.ceylon`:

<!-- try: -->
    import ceylon.json { parseJson = parse, JsonObject = Object, JsonArray = Array }
    
    shared void run() {
        dynamic {
            // The HTML element where we'll add our items
            dynamic target = jQuery("#target");
            // The function called when we get data from the server
            void success(dynamic data){
                // Parse the JSON
                assert(is JsonObject json = parseJson(data),
                       is JsonArray results = json["results"]);
                // Iterate modules
                for(res in results){
                  assert(is JsonObject res);
                  // Get the list of versions
                  assert(is String name = res["module"],
                         is JsonArray versions = res["versions"]);
                  // Join them
                  value versionText = ", ".join(versions.narrow<String>());
                  // Now add the HTML items
                  dynamic item = jQuery("<paper-item/>");
                  dynamic body = jQuery("<paper-item-body two-line/>").appendTo(item);
                  jQuery("<div/>").text(name).appendTo(body);
                  jQuery("<div secondary/>").text(versionText).appendTo(body);
                  target.append(item);
                }
            }
            // Query Herd for the list of modules
            jQuery.get("https://modules.ceylon-lang.org/api/1/complete-modules?module=ceylon.", null, success, "text");
        }
    }

Now, obviously using `jQuery` to add HTML is far from ideal, so I can't wait for someone to
extend [ceylon.html](https://herd.ceylon-lang.org/modules/ceylon.html) to allow Polymer web
components!

We can now compile our application for JavaScript:

<!-- try: -->
<!-- lang: bash -->
    $ ceylon compile-js

And copy our compiled module and all its dependencies to where the Apache Cordova application
will find them in `www/modules`:

<!-- try: -->
<!-- lang: bash -->
    $ ceylon copy --with-dependencies --js --out www/modules cordova.demo/1.0.0

## Invoking the Ceylon module from the Cordova application

Because we're going to use `require.js` inline and connect to Ceylon Herd, we have to adjust the Apache
Cordova permissions in `www/index.html`, so find that line and edit it as such:

<!-- try: -->
<!-- lang: html -->
    <meta http-equiv="Content-Security-Policy" content="default-src 'self' 'unsafe-inline' https://fonts.googleapis.com https://fonts.gstatic.com; connect-src *">

We're left with just invoking our Ceylon function in `www/index.html`:

<!-- try: -->
<!-- lang: html -->
    <script type="text/javascript">
      // tell require.js where our Ceylon modules are 
      require.config({
        baseUrl:'modules',
      });
      // when the document is ready
      jQuery(function(){
        // load our Ceylon module
        require(['cordova/demo/1.0.0/cordova.demo-1.0.0'], function(client) {
          // and call our run method
          client.run();
        });
    });
    </script>

And setting up the target HTML elements where we're going to add every loaded module (in
the same file):

<!-- try: -->
<!-- lang: html -->
    <body id="app" unresolved>
      <app-shell class="fit">
        <div id="target" role="listbox"></div>
      </app-shell>
    </body>

## Trying it

And that's it, try it out in your browser:

<!-- try: -->
<!-- lang: bash -->
    $ cordova platform run browser
Or in an Android emulator:

<!-- try: -->
<!-- lang: bash -->
    $ ANDROID_HOME=.../Android/Sdk cordova platform build android
    $ ANDROID_HOME=.../Android/Sdk cordova platform run android

If you have OSX and iOS dev tools, please try this with the iOS Cordova platform and let
me know how it works :)

In the future, we would benefit from having a type-safe API in front of the Cordova JavaScript
API that lets you access native mobile APIs such as the camera, GPS, contacts, but even without
it you can already use them using `dynamic` blocks.

And now for the teaser… this is only one method to run Ceylon on Android, because obviously it
may be more desirable to use the JVM compiler backend and integrate with the Android Tools to
run Ceylon on Android using only type-safe APIs. Don't worry, it's coming, and next week I will
show you how :)
