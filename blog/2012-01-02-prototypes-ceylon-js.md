---
title: Prototypes vs lexical scope in the Ceylon JavaScript 
       compiler
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags: [ceylon-js]
---

[ceylon-js]: https://github.com/ceylon/ceylon-js
[previous post]: /blog/2011/12/31/compiling-ceylon-2-js

In the [previous post][] I introduced the [Ceylon JavaScript
compiler project][ceylon-js]. One of the things I mentioned
was that there was an extremely natural mapping from Ceylon 
to JavaScript making use of JavaScript's lexical scope to
create nicely encapsulated JavaScript objects. For example,
given the following Ceylon code:

    shared class Counter(Integer initialCount=0) {
        variable value currentCount:=initialCount;
        shared Integer count {
            return currentCount;
        }
        shared void inc() {
            currentCount:=currentCount+1; 
        }
    }

We produce the following JavaScript:

<!-- lang: js -->
    var $$$cl15=require('ceylon/language/0.1/ceylon.language');
    
    //class Counter at members.ceylon (1:0-9:0)
    this.Counter=function Counter(initialCount){
        var $$counter=new CeylonObject;
        
        //value currentCount at members.ceylon (2:4-2:45)
        var $currentCount=initialCount;
        function getCurrentCount(){
            return $currentCount;
        }
        function setCurrentCount(currentCount){
            $currentCount=currentCount;
        }
        
        //value count at members.ceylon (3:4-5:4)
        function getCount(){
            return getCurrentCount();
        }
        $$counter.getCount=getCount;
        
        //function inc at members.ceylon (6:4-8:4)
        function inc(){
            setCurrentCount(getCurrentCount().plus($$$cl15.Integer(1)));
        }
        $$counter.inc=inc;
        
        return $$counter;
    }

Notice that this code is really quite readable and really
not very different to the original Ceylon.

Let's load this module up in the node REPL, and play with the
`Counter`.

<!-- lang: js -->
    > Counter = require('./node_modules/default/members').Counter
    [Function: Counter]
    > Integer = require('./runtime/ceylon/language/0.1/ceylon.language').Integer
    [Function: Integer]
    > c = Counter(Integer(0))
    { getCount: [Function: getCount], inc: [Function: inc] }

The `Counter` instance presents a nice clean API with
`getCount()` and `inc()` functions:

<!-- lang: js -->
    > c.getCount().value
    0
    > c.inc()
    > c.inc()
    > c.getCount().value
    2

Notice that the actual value of `$$counter` is completely 
hidden from the client JavaScript code. Another nice thing
about this mapping is that it is completely free of 
JavaScript's well-known broken `this`. I can freely use the
methods of `c` by reference:

<!-- lang: js -->
    > inc = c.inc
    [Function: inc]
    > count = c.getCount
    [Function: getCount]
    > inc()
    > count().value
    3

Now, an issue that was bugging me about this mapping - and
bugging Ivo even more - is the performance cost of this 
mapping compared to statically binding the methods of a class
to its prototype. Ivo did some tests and found that it's up
to like 100 times slower to instantiate an object that 
defines its methods in lexical scope instead of using its
prototype on V8. Well, that's not really acceptable in
production, so I've added a switch that generates code that
makes use of prototypes. With this switch enabled, then for 
the same Ceylon code, the compiler generates the following:

<!-- lang: js -->
    var $$$cl15=require('ceylon/language/0.1/ceylon.language');
    
    //ClassDefinition Counter at members.ceylon (1:0-12:0)
    function $Counter(){}
    
    //AttributeDeclaration currentCount at members.ceylon (2:4-2:45)
    $Counter.prototype.getCurrentCount=function getCurrentCount(){
        return this.currentCount;
    }
    $Counter.prototype.setCurrentCount=function setCurrentCount(currentCount){
        this.currentCount=currentCount;
    }
    
    //AttributeGetterDefinition count at members.ceylon (3:4-5:4)
    $Counter.prototype.getCount=function getCount(){
        return this.getCurrentCount();
    }
    
    //MethodDefinition inc at members.ceylon (6:4-8:4)
    $Counter.prototype.inc=function inc(){
        this.setCurrentCount(this.getCurrentCount().plus($$$cl15.Integer(1)));
    }
    
    this.Counter=function Counter(initialCount){
        var $$counter=new $Counter;
        $$counter.initialCount=initialCount;        
        return $$counter;
    }

Clearly this code is a bit harder to understand than what we
started with. It's also a lot uglier in the REPL:

<!-- lang: js -->
    > c = Counter(Integer(0))
    { initialCount: { value: 0, ... } }

Notice that the internal state of the object is now exposed to
clients. And all its operations - held on the prototype - are 
also accessible, even the non-`shared` operations. Finally, 
JavaScript's `this` bug is back:

<!-- lang: js -->
    > inc = c.inc
    [Function: inc]
    > inc()
    TypeError: Object #<error> has no method 'getCurrentCount'
        at inc (/Users/gavin/ceylon-js/build/test/node_modules/default/members.js:21:31)
        ...

We have to use the following ugly workaround:

<!-- lang: js -->
    > inc = function(){c.inc.apply(c,arguments)}
    > inc()
    > c.getCount().value
    1

(Of course, the compiler automatically inserts these wrapper
functions when write a function reference at the Ceylon 
level.)

Personally, I don't really see why the JavaScript interpreter
in V8 could not in principle internally optimize our original 
code to something more like our "optimized" code. I think it
would make JavaScript a much more pleasant language to deal
with if there wasn't such a big difference in performance
there.

Anyway, if you're producing your JavaScript by writing Ceylon, 
this is now just a simple compiler switch :-)

