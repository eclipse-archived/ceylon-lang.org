---
title: Java Reflection oddities with inner class constructor parameters
author: St&#233;phane &#201;pardaud
layout: blog
unique_id: blogpage
tab: blog
tags: [java, code]
---

# About Java inner classes

Java allows member classes (classes that are defined inside other classes), local classes
(classes that are defined inside statement blocks) and anonymous classes (classes with no
names):

<!-- try: -->
<!-- lang: java -->
    class Outer {
        Object anonymous = new Object(){}; // this is an anonymous class
        
        // anonymous initialisation block
        {
            // this is a local class
            class Local{}
            Local l = new Local();
        }

        Outer() {
            // this is a local named class in a constructor
            class Local{}
            Local l = new Local();
        }
        
        void method() {
            // this is a local named class in a method
            class Local{}
            Local l = new Local();
        }
        
        // this is a member class
        class Inner{}
        Inner i = new Inner();
    }

The [Java Language Specification](http://docs.oracle.com/javase/specs/jls/se7/html/jls-8.html#jls-8.1.3)
classifies member, local and anonymous classes as _inner classes_.

# Implementation “details”

What the Java Language or Virtual Machine specifications do not tell you is _how_ they are implemented.
Some of it is explained already in [other articles](http://www.dzone.com/links/r/java_secret_generated_methods.html),
such as how the Java compiler generates _synthetic_ methods to allow these members classes access to
private fields, which would not be allowed by the JVM.

Another implementation detail of inner classes that is handy to know is that inner class constructors
take extra _synthetic_ parameters. It is relatively 
[well-known](http://thecodersbreakfast.net/index.php?post/2011/09/26/Inner-classes-and-the-myth-of-the-default-constructor)
that the first synthetic parameter of an inner class constructor will be its enclosing instance, which
it will store in a `this$X` synthetic field. This is valid for all three kinds of inner classes: member,
local and anonymous.

But it is generally not known that local classes who _capture_ non-constant final variables will require
all these variables to be passed as extra synthetic constructor parameters (captured constant final
variables will be inlined and not generate extra synthetic constructor parameters):

<!-- try: -->
<!-- lang: java -->
    class Outer {
        void method() {
            final String constant = "foo";
            final String nonConstant = "foo".toUpperCase();
            class Local{
                /* synthetic fields and constructor: 
                
                Outer this$0;
                String nonConstant;
                
                Local(Outer this$0, String nonConstant){
                    this.this$0 = this$0;
                    this.nonConstant = nonConstant;
                }
                */
            }
            Local l = new Local();
        }
    }

# OK, but why should I care?

In most cases you don’t care, other than for your own curiosity. But if you’re doing Java reflection with inner classes,
there are a few things you should know, and because I haven’t found them listed or specified online, I thought it would
be important to make a list of things to help others figure it out, because different compilers will produce different
results in the Java reflection API.

The question is what happens when you use Java reflection to get a `java.lang.reflect.Constructor` instance for inner
class constructors? In particular, what happens with the methods that allow you to access the parameter types (pre-generics:
`getParameterTypes()`), the generic parameter types (post-generics: `getGenericParameterTypes()`) and annotations 
(`getParameterAnnotations()`), and the answer is: _it depends_.

Suppose the following Java class:

<!-- try: -->
<!-- lang: java -->
    class Outer {
        class Inner {
            Inner(){}
            Inner(String param){}
            Inner(@Deprecated Integer param){}
        }
    }

Here are the size of the arrays returned by these three reflection methods, on each of our
constructor, and how they differ depending on the Java compiler used:

<table style="font-size: smaller;">
 <tr>
  <th></th>
  <th><tt>Outer.Inner.class<br/> .getDeclaredConstructor()</tt></th>
  <th><tt>Outer.Inner.class<br/> .getDeclaredConstructor(<br/>  String.class)</tt></th>
  <th><tt>Outer.Inner.class<br/> .getDeclaredConstructor(<br/>  Integer.class)</tt></th>
 </tr>
 <tr>
  <td><tt>getParameterTypes()<br/> .length</tt></td>
  <td>1</td>
  <td>2</td>
  <td>2</td>
 </tr>
 <tr>
  <td><tt>getGenericParameterTypes()<br/> .length</tt> compiled with Eclipse</td>
  <td>1</td>
  <td>2</td>
  <td>2</td>
 </tr>
 <tr>
  <td><tt>getGenericParameterTypes()<br/> .length</tt> compiled with Javac</td>
  <td>0</td>
  <td>1</td>
  <td>1</td>
 </tr>
 <tr>
  <td><tt>getParameterAnnotations()<br/> .length</tt></td>
  <td>2</td>
  <td>2</td>
  <td>1</td>
 </tr>
</table>

As you can see, the synthetic parameters are always included in `getParameterTypes()`,
but are only included in `getGenericParameterTypes()` when compiled with Eclipse.

`getParameterAnnotations()` on the other hand, will always include synthetic parameters
except when at least one of your constructor parameters are annotated.

With this info, you now understand the differences between the results of these methods,
but so far I still haven’t found a way to determine which parameter is synthetic or not,
because although you can make a good guess for the `this$X` synthetic parameter, which
is required by every inner class, you have no way of knowing the number of non-constant
captured variables that will end up as synthetic parameters to local class constructors.