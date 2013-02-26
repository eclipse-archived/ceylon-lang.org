---
title: Ceylon in the browser
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags: [httpd, ceylon-js]
---

Last week, we met the [Ceylon HTTP server](/blog/2013/02/21/httpd/),
which we can use to serve dynamic (or even static) content over HTTP.
But what about the client side? Well, today we're going to write a
little HTTP client that runs in the browser, mainly as a way of
showing off Ceylon's new `dynamic` blocks.

First, let's see the server, in a module named `hello.server`:

<!-- try: -->
    import ceylon.net.httpd { createServer, startsWith, 
                              AsynchronousEndpoint, 
                              Request, Response }
    import ceylon.net.httpd.endpoints { serveStaticFile }
    
    void run() {
        createServer{ 
            AsynchronousEndpoint { 
                path = startsWith("/sayHello"); 
                void service(Request request, Response response, 
                        void complete()) {
                    response.writeString("Hello, Client!");
                    complete(); //async response complete
                }
            },
            AsynchronousEndpoint {
                path = startsWith(""); 
                service = serveStaticFile("../client");
            } 
        }
        .start();
    }

The server has two asynchronous endpoints, one of which simply
serves up static content out of the directory `../client`, and
the other of which just responds to requests with the text 
`Hello, Client!`.

The entrypoint to our application is a HTML page.

<!-- lang: html -->
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <meta http-equiv="Content-type" 
                  content="text/html;charset=UTF-8"/>
            <title>Hello</title>
            <script type="text/javascript"
                    src="script/require/1.0.8/require.js">
            </script>
            <script type="text/javascript">
                require.config({
                    // location of our project's compiled modules
                    baseUrl: 'modules',
                    // locations of external dependencies here
                    paths: {
                        // path to the Ceylon language module 
                        'ceylon/language': 
                            '/script/ceylon/language'
                    }
                });
                //alias our hello module to 'h'
                require(['hello/client/1/hello.client-1'], 
                        function (hello) { h = hello; });
            </script>
        </head>
        <body>
            <div>
                <input type="submit" 
                       value="Say hello" 
                       onclick="h.hello()"/>
            </div>
            <div>
                <span id="greeting"/>
            </div>
        </body>
    </html>

The page has a button which calls the `hello()` function of the
Ceylon module `hello.client`.

We're using `require.js` to load our Ceylon modules. Unfortunately
`require.js` doesn't really have a concept of module repositories 
like Ceylon does, which means configuring it to find all our 
compiled Ceylon is a bit fiddly. Nor does it feature very good
error reporting which turns "fiddly" into "time-wasting". (The
implementation of `require()` in `node.js` is a _much_ better fit,  
but unfortunately we don't have that in the browser.)

Finally, the module named `hello.client` has the following function:

<!-- try: -->
    shared void hello() {
        dynamic {
            value req = XMLHttpRequest();       
            void handleResponse() {
                if (req.readyState==4) {
                    document.getElementById("greeting")
                            .innerHTML = req.status==200 
                                    then req.responseText 
                                    else "error";
                }
            }
            req.onreadystatechange = handleResponse;
            req.open("GET", "/sayHello", true);
            req.send();
        }
    }

This function makes use of the native JavaScript API `XMLHttpRequest` 
to send an asynchronous request to our server, and then interacts 
with the browser's DOM. But how on earth can a statically typed 
language like Ceylon call a weakly typed language like JavaScript!?

Well, code that appears inside a `dynamic` block is _optionally typed_.
That is, Ceylon will make use of typing information when it is 
available, but when it is not, it will just shut up and let you write
almost whatever you like, as long as it's syntactically well-formed 
Ceylon code. Ceylon can't be certain that there's really a function
called `XMLHttpRequest`, and it certainly can't be sure that it has a 
member named `onreadystatechange`, but it will just assume you know 
what you're doing.

Inside a `dynamic` block, you can even _instantiate_ a "dynamic" 
object:

<!-- try: -->
    dynamic {
        void printGreeting(value obj) {
            console.log(obj.greeting + " " + obj.language);
        }
        value obj = value { greeting="Hello"; language="Ceylon"; };
        printGreeting(obj);
    } 

Of course, inside a `dynamic` block, all kinds of typing errors can
occur at runtime, things that the Ceylon compiler would usually detect
at compile time. But the compiler at least protects you from having
dynamic typing errors "leak" out of the `dynamic` block and into your
regular Ceylon code by performing runtime checks when you assign a
dynamically typed expression (that is, an expression of unknown type)
to something with a well-defined static type.

Well, that's essentially all there is to our application, except for
a couple of boring module and package descriptors. Here we can see a
sever written in Ceylon running in the JVM being called by a client
written in Ceylon running in a web browser and interacting with the
browser's native JavaScript APIs. I think that's pretty cool.

A note of caution: we're still working through some wrinkles in the 
semantics of `dymamic`, and `dynamic` is still not supported by the
on the JVM (it will be, eventually). Nevertheless, this will be 
available as an experimental feature in Ceylon M5.
