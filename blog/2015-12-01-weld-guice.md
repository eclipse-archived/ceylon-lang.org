---
title: Dependency injection in Ceylon with Weld and Guice 
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags: [weld, guice]
---

I'm personally ambivalent about the benefits of dependency 
injection. On the one hand, I recognize its usefulness in 
certain container environments such as Java EE. (For the
record, I was the author of the CDI 1.0 specification, with
my JCP Expert Group.) On the other hand, given the nature of 
what I've been working on for the last few years, I don't 
really have a use for it in my own programs.

But there are plenty of folks out there who swear by 
dependency injection, and ask me what Ceylon offers in this 
area. The short answer is: nothing special; the Ceylon SDK is 
architected around the notion of modular libraries. It offers
neither framework nor container. This makes the SDK as general
purpose as possible, meaning it can be reused from any other
container environment (say, Java EE, vert.x, OSGi, or whatever).

So if you want dependency injection in Ceylon today, you're
going to have to use a container written in Java. Fortunately,
Ceylon 1.2 features such excellent interoperation with Java
that this results in barely any friction at all. Surely 
someone will write a dependency injection container in Ceylon
_some day_, but, as we're about to see, there's no urgency at
all.

I'm going to explore:

- [Weld](http://weld.cdi-spec.org/), which is the reference 
  implementation of CDI, developed by my colleagues at Red Hat, 
  and, 
- in the interests of giving equal time to a "competitor", 
  Google's [Guice](https://github.com/google/guice), originally
  written by my friend Bob Lee, which was one of the major 
  influences on the CDI specification.

These are my favorite containers for Java, though of course 
Spring has legions of fans. Perhaps I'll find time to play with
it some other day.

You can find the example code in the following Git repository:

<https://github.com/ceylon/ceylon-examples-di>

## Weld

I found it extremely straightforward to use Weld in Ceylon,
except for one relatively minor problem, which I'll mention 
below.

### Module descriptor for Weld

Weld provides a fat jar in Maven Central, which makes it 
especially easy to use in Ceylon. I used the following module
descriptor to download Weld from Maven Central and import it 
into my project:

<!-- try: -->
    native("jvm")
    module weldelicious "1.0.0" {
        import "org.jboss.weld.se:weld-se" "2.3.1.Final";
        import ceylon.interop.java "1.2.0";
    }

Where `org.jboss.weld.se` is the Maven _group id_, and `weld-se`
is the Maven _artifact id_. (I have not the slightest clue what 
these things actually mean, I just know there are two of them.)

I also imported the Ceylon SDK module `ceylon.interop.java`
because I'm going to use its `javaClass()` function.

### Bootstrapping Weld

Though it's not part of the CDI specification, Weld offers a
very simple API for creating a container. I copy/pasted the
following code from stackoverflow:

<!-- try: -->
    import org.jboss.weld.environment.se { Weld }
    
    shared void run() {
        
        value container = Weld().initialize();
        
        //do stuff with beans
        ...
        
        container.shutdown();
        
    }

I tried to run this function.

### Gotcha!

Just like every other CDI developer _ever_, I forgot the
`beans.xml` file. Fortunately, Weld gave me a rather clear 
error message. Not quite as poetic as 
["se te escapó la tortuga"](http://qriollo.github.io), 
perhaps, but good enough to remind me of this requirement of 
the spec. (Yeah, the spec I wrote.)

To resolve the problem, I added an empty file named 
`beans.xml` to the directory `resource/weldelicious/ROOT/META-INF`,
which is the magical location to use if you want Ceylon to 
put a file into the `META-INF` directory of a module archive.

### Defining Weld beans

I defined the following interface, for a bean I hoped to 
inject:

<!-- try: -->
    interface Receiver {
        shared formal void accept(String message);
    }

Next, I defined a bean which depends on an instance of this 
interface:

<!-- try: -->
    import javax.inject { inject }

    inject class Sender(Receiver receiver) {
        shared void send() => receiver.accept("Hello!");
    }

(The `inject` annotation is the thing you write `@Inject` in
Java.)

Finally, we need a bean which implements `Receiver`:

<!-- try: -->
    class PrintingReceiver() satisfies Receiver {
        accept = print;
    }

### Obtaining and calling a bean

Going back to the `run()` function, I added some code to
obtain a `Sender` from the container, and call `send()`:

<!-- try: -->
    import org.jboss.weld.environment.se { Weld }
    import ceylon.interop.java { type = javaClass }
    
    shared void run() {
        
        value container = Weld().initialize();
        
        value sender 
                = container
                    .select(type<Sender>())
                    .get();
        
        sender.send();
        
        weld.shutdown();
        
    }

Note that I'm using the `javaClass()` function to obtain an
instance of `java.lang.Class` for the Ceylon type `Sender`.
An alternative approach, which uses only a CDI API, and which
also works for generic types, is to use 
`javax.enterprise.inject.TypeLiteral`:

<!-- try: -->
    value sender 
            = container
                .select(object extends TypeLiteral<Sender>(){})
                .get();

Unfortunately, that's a little more verbose.

### Named constructor injection

Using a little quick fix in the IDE, we can transform the 
`Sender` class into a class with a default constructor:

<!-- try: -->
    class Sender {
        Receiver receiver;
        inject shared new (Receiver receiver) {
            this.receiver = receiver;
        }
        shared void send() => receiver.accept("Hello!");
    }

As far as Weld is concerned, this is the same as what we had
before.

But we can even give our constructor a name:

<!-- try: -->
    class Sender {
        Receiver receiver;
        inject shared new inject(Receiver receiver) {
            this.receiver = receiver;
        }
        shared void send() => receiver.accept("Hello!");
    }

Due to unanticipated serendipity, this actually Just Works.

### Method and field injection

I don't think that method or field injection is a very natural 
thing to do in Ceylon, and so I don't recommend it. However, it
does work, just as long as you mark any fields initialized by
injection with the `late` annotation:

This works, but doesn't feel very Ceylonic:

<!-- try: -->
    class Sender() {
        inject late Receiver receiver;
        shared void send() => receiver.accept("Hello!");
    }

This works too:

<!-- try: -->
    class Sender() {
        late Receiver receiver;
        inject void init(Receiver receiver) {
            this.receiver = receiver;
        }
        shared void send() => receiver.accept("Hello!");
    }

### Using a CDI producer

One nice thing about using Ceylon with Weld is that you can
use the `produces` annotation on a toplevel function.

<!-- try: -->
    import javax.enterprise.inject { produces }
    
    produces Receiver createReceiver() 
            => object satisfies Receiver {
                accept = print;
            };

### CDI qualifiers

We can define CDI qualifier annotations in Ceylon:

<!-- try: -->
    import javax.inject { qualifier }
    
    annotation Fancy fancy() => Fancy();
    final qualifier annotation class Fancy() 
            satisfies OptionalAnnotation<Fancy> {}

A qualifier annotation must be applied at both the injection
point and to the bean or producer function. First, I annotated
the bean class:

<!-- try: -->
    fancy class FancyReceiver() satisfies Receiver {
        accept(String message) 
                => print(message + " \{BALLOON}\{PARTY POPPER}");
    }

Next, I tried annotating an injected initializer parameter:

<!-- try: -->
    //this doesn't work!
    inject class Sender(fancy Receiver receiver) {
        shared void send() => receiver.accept("Hello!");
    }

Unfortunately, this didn't work. When compiled to Java 
bytecode, Ceylon actually places this `fancy` annotation on 
a generated getter method of `Sender`, not on the parameter, 
and Weld only looks for qualifier annotations on injected 
parameters. I had to use constructor injection to make the 
qualifier work right:

<!-- try: -->
    //this does work
    inject class Sender {
        Receiver receiver;
        shared new (fancy Receiver receiver) {
            this.receiver = receiver;
        }
        shared void send() => receiver.accept("Hello!");
    }

For the record, qualifier annotations also work with method 
injection. They don't work with field injection.

This was the only disappointment I had using Weld with Ceylon,
and I believe I already know 
[how to solve this](https://github.com/ceylon/ceylon/issues/5779) 
in Ceylon 1.2.1. 

### Scoped beans

You can define scoped beans (beans with what the CDI spec
calls a _normal scope_) in Ceylon, just by applying a scope
annotation to the bean:

<!-- try: -->
    import javax.enterprise.context { applicationScoped }
    
    applicationScoped
    class PrintingReceiver() satisfies Receiver {
        accept = print;
    }

However, there's something to be careful of here: CDI creates
proxies for scoped beans, and since the operations of a Ceylon
class are "final" by default, you have a choice between:

- annotating all operations of the bean `default`, or
- injecting an interface instead of the concrete bean class.

I think the second option is a much better path to go down, 
and is probably even the best approach in Java.

Surely the same caveat applies to beans with CDI interceptors 
or decorators, though I did not test that.

Weld offers *lots* of additional functionality which I did not
have time to test, but that I anticipate will work in Ceylon. 

## Guice

Guice was also pretty easy to get set up, though I wasted a bit
of time on the Maven side of things.

### Module overrides for Guice

Guice doesn't come in a fat jar, so we'll have to deal with a
common problem when using Maven modules from Ceylon. Maven is
designed for a flat Java classpath, so a Maven module doesn't 
come with metadata about which of its dependencies are 
re-exported via its public API. There are three basic strategies
for solving this problem:

1. Compile and run with a flat classpath by using 
   `--flat-classpath`. This makes Ceylon work like Java, and
   robs us of module isolation.
2. Use `--export-maven-dependencies` to re-export _all_ 
   dependencies of every Maven module.
3. Use an `overrides.xml` file to explicitly specify which
   dependencies are re-exported.

We're going to go with option 3, since it's the hardest.

But wait&mdash;you must be thinking&mdash;_XML?!_ And yeah, 
don't worry, we hate XML just as much as you do. This is a 
stopgap measure until Ceylon has real _assemblies_. Once we 
have assemblies, you'll be able to override module dependencies 
in a Ceylon assembly descriptor.

Anyway, after that longwinded preamble, all I had to do was
mark `javax.inject` as a shared dependency:

<!-- lang: xml-->
    <overrides xmlns="http://www.ceylon-lang.org/xsd/overrides">
        <module groupId="com.google.inject" 
             artifactId="guice" 
                version="4.0">
            <share groupId="javax.inject" 
                artifactId="javax.inject"/>
        </module>
    </overrides>

You're very welcome to copy and paste the above bit of 
boilerplate into your own Ceylon and Guice projects.

### Module descriptor for Guice

The following module descriptor fetches Guice and its dependencies
from Maven Central, and imports Guice into the project:

<!-- try: -->
    native("jvm")
    module guicy "1.0.0" {
        import "com.google.inject:guice" "4.0";
        import ceylon.interop.java "1.2.0";
    }

### Code we can reuse from the Weld example

Since Guice recognizes the `inject` annotation defined in
`javax.inject`, we can reuse the definitions of `Sender`, 
`Receiver`, and `PrintingReceiver` we started out with above.

<!-- try: -->
    import javax.inject { inject }

    inject class Sender(Receiver receiver) {
        shared void send() => receiver.accept("Hello!");
    }

    interface Receiver {
        shared formal void accept(String message);
    }
    
    class PrintingReceiver() satisfies Receiver {
        accept = print;
    }

### Bootstrapping Guice

Guice has the notion of a _module_ object, which has a collection
of _bindings_ of types to objects. Unlike Weld, which automatically
scans our module archive looking for beans, bindings must be 
registered explicitly in Guice.

<!-- try: -->
    import ceylon.interop.java {
        type = javaClass
    }
    import com.google.inject {
        AbstractModule,
        Guice {
            createInjector
        },
        Injector
    }
    
    Injector injector
            = createInjector(
        object extends AbstractModule() {
            shared actual void configure() {
                bind(type<Receiver>()).to(type<PrintingReceiver>());
            }
        });

This code binds the implementation `PrintingReceiver` to the
interface `Receiver`.

### Obtaining and calling an object

Now it's easy to obtain and call a container-bound instance
of `Sender`:

<!-- try: -->
    import ceylon.interop.java {
        type = javaClass
    }
    
    shared void run() {
        value sender = injector.getInstance(type<Sender>());
        sender.send();
    }

We're again using `javaClass()`, but Guice has its own `TypeLiteral`.
(For the record, CDI stole `TypeLiteral` from Guice.)

<!-- try: -->
    import com.google.inject {
        Key,
        TypeLiteral
    }
    
    shared void run() {
        value key = Key.get(object extends TypeLiteral<Sender>(){});
        value sender = injector.getInstance(key);
        sender.send();
    } 

### Constructor injection

Injection into default constructors works, and looks exactly
like what it looks like for Weld. However, injection into named
constructors doesn't work with Ceylon 1.2.0 and Guice 4.0. This
is [pretty easy to fix](https://github.com/ceylon/ceylon/issues/5777) 
on our side, and so it should work in Ceylon 1.2.1.

### Method and field injection

The creators of Guice strongly prefer constructor injection, 
which is, as we have observed, also more natural in Ceylon.
But method and field injection works fine, as with Weld, if
you mark injected field `late`.

### Provider methods

Guice scans the module object for methods annotated `provides`.

<!-- try: -->
    import com.google.inject {
        AbstractModule,
        Guice {
            createInjector
        },
        Injector,
        provides
    }
    
    Injector injector
            = createInjector(
        object extends AbstractModule() {
            shared actual void configure() {}
            provides Receiver createReceiver()
                    => object satisfies Receiver {
                        accept = print;
                    };
        });

I find this significantly inferior to the approach in CDI 
where producer methods can be defined as toplevel functions.

### Binding annotations

Guice's _binding annotations_ work almost exactly like CDI
qualifier annotations (since that's where CDI copied them from).
The code to define a binding annotation is exactly the same 
as for Weld.

<!-- try: -->
    import javax.inject { qualifier }
    
    annotation Fancy fancy() => Fancy();
    final binding annotation class Fancy() 
            satisfies OptionalAnnotation<Fancy> {}

The qualifier annotation must be specified when defining a
binding:

<!-- try: -->
    Injector injector
            = createInjector(
        object extends AbstractModule() {
            shared actual void configure() {
                bind(type<Receiver>())
                    .to(type<PrintingReceiver>());
                bind(type<Receiver>())
                    .annotatedWith(Fancy()) //binding annotation
                    .to(type<FancyReceiver>());
            }
        });

Just like in Weld, qualifier annotations work with constructor
or method injection, but don't currently work with initializer 
parameter or field injection.

### Scoped beans

Like CDI, Guice has scoped objects.

<!-- try: -->
    import com.google.inject { singleton }
    
    singleton
    class PrintingReceiver() satisfies Receiver {
        accept = print;
    }

I didn't have time to test this feature of Guice extensively, 
but I happen to know that Guice doesn't use proxies, so it's 
not necessary to use an interface instead of a concrete class.

## Conclusion

If you want dependency injection in Ceylon, it's clear that 
you have at least two excellent options.
