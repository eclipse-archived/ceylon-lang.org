# Serialization for Ceylon

We've been promising serialization for Ceylon for a while now and with 1.2.1 
we will finally have something people can play about with, so now seems 
like a good time to start talking about it.

## The abstract problem

Let's start with what we mean by serialization. Serialization is about solving 
the problem of how to transfer a bunch of objects from one VM to another 
(possibly the same) VM. Exactly how the necessary information gets between 
the VMs is mostly boring (it could be in memory, via persistence storage, 
via the network or whatever), this article is concerned about what that 
*information* consists of. So drop your thoughts about the relative merits of
various file formats and let's focus on the abstract problem for a 
moment or two.

We have a bunch of objects. Each of those objects has some state, which 
mostly consistes of references to other objects. So to serialise this object 
we also need to serialize the objects it has references too. 
In general, the objects we want to serialize form a (set of) 
directed graphs. The objects are the vertices of the graphs, 
their references are the edges between the vertices. 
It's a *set of* graphs because our bunch of objects might form several disjoint 
graphs. For the purposes of this blog, let's make the simplifying assumption 
that we've got a single object graph.

Time for a silly example:

    class Foo(object) {
        shared Anything object;
    }
    class Bar(int, str) {
        shared Integer int;
        shared String str;
    }
    value foo=Foo(Bar(1, "hello"));

Which results in an instance graph like this:

    foo ----> bar ----> 1
               |
               |
               v
            "hello"

There are several further things to notice.

Firstly, the graph may have cycles. For example, this class

    class Character() {
        shared variable Character? nemesis;
    }
    
very quickly results in lots of cycles:

             nemesis
    ripley ------------> alien
      ^                   |
      |     nemesis       |
      +-------------------+

Second, the state of most instances consists of their references to other 
instances. In the `Character` example there's the single reference are`nemesis`.
However, the instances of some classes cannot be decomposed. 
For example `Boolean` can't be decomposed into anything simpler. While it might 
make conceptual sense to draw the line at `Boolean` we actually take things 
higher and include `Integer`, `Byte`, `Character`, `Float` and `String`
in the set of classes which we can't decompose. The main reason for that is 
simply that this whole "Ceylon Serialization" thing has to work on both JVM 
and JS and below this sort of level, intellectual purity is going to 
start costing a lot in terms of performance. So some built-in classes are not 
decompsable, but most other classes, in principle, can be decomposed.

Third, in order to be able to reconstruct any particular object we need to know 
about it's *complete* state. And that includes state which is not `shared`. 
That because even un-`shared` state has a bearing on how a class actually 
works. The practical upshot of this is that for serialization to work it 
*necessarily* exposes a class' internal references to anyone who cares to 
look.

Fourth, each object in the graph is an instance of a **single class** 
at serialization time. We only care about inheritance because superclasses
might have state that we need to serialize. We don't care about 
superinterfaces at all.

Fifth, my graph might 
consist of two distinct instances with identical references. For example:

    class Baz() {}
    value b1 = Baz();
    value b2 = Baz();
    
In the serializing VM `b1 === b2` would be false, so we ought to preserve that 
in the deserializing VM. We need to preserve *identity*. We can cope with 
that by labelling each vertex in the graph with something to represent 
its identity. We can do that with a function:

    Object identity(Anything instance)

The return type doesn't matter very much, so long as:

* `identity` returns different (as in not `==`) objects when given two different (as in not `===`)  instances. 
* `identity` returns the same (as in `==`) object when given the same (as in `===`) instance.

One gotcha is that 
Ceylon allows `Object`s which are not `Identifiable`, so 
what do we do about those instances? Well there's not a lot we can do, 
except give them an identity based on their equality (as in `==`).

So, to describe an instance graph we're going to need:

* A way to reason about the identity of instances 
  (the `identity` function we just discussed).
* A way to describe the runtime types of instances 
  (we have `ceylon.language.meta.model::Class`)
* A way to discover the runtime type of instances 
  (we have `ceylon.language.meta::type`)
* A way to describe the state (i.e. the reference values) an instance holds
  (we have `ceylon.language.meta.declaration::ValueDeclaration`)
* A way to discover the particular references an instance holds
  (this is what the Ceylon serialization API provides)

That should be enough to describe what any particular instance graph looks 
like. To actually recreate one from such a description we will need:

* A way to instantiate a given class
* A way to inject an instance's state

The observant will notice how I used two bullet points there, as if those are 
separate things. Well for serialization they *are* separate. Remember how 
I pointed out that instance graphs can have cycles? Well it's impossible 
to form a reference cycle without the ability to instantiate first 
and set references later.

But if you can instantiate an instance without fully initializing it that means 
there's a time during which it's uninitialized. The Ceylon langauage 
goes to some lengths to avoid programmers being 
exposed to partially initialized instances. It would be a shame if, after 
those efforts, we went unleasing partially initialized objects into the VM 
via the deserialization API. We really need an API which prevents access 
to instances until they're fully initialized.

So far this has all been very abstract, so lets take a break to think about
use cases...

## The concrete problem

Back in the real world we have a concrete problem to solve. We have a 
particular bunch of objects we which to recreate on a particular VM.

The meta problem is that everyones problem is different. We need 
"Ceylon serialization" to cater for all those problems. Let's describe 
the problem space:

* Some people will care about what the serialzed form looks like, others won't care
* Some people will only need serialization, others just deserialization, many will need both,
* Some people will need blistering performance,
* In some cases we will know what kind of object we're expecting in the 
  deserializing VM, but in others we won't know.
* Some people won't have to worry about schema evoluion, others will.
* Some people will only need to be able to serialize a handful of types, 
  others will need to be able to serialize the widest possible range of 
  classes.

It should be obvious that there are lots of trade-offs to be made here, and 
it's going to be impossible to please everyone. This means 
"Ceylon serialization" shouldn't be baked into the language module, because 
that would necessarily mean some people's use cases went unmet. Instead we need 
the language module to provide just enough abstraction to allow different 
implementations. Those implementations are called "serialization libraries", 
and the abstractions in `ceylon.language` are called the serialization API. 
(Calling it "the serialization API" is a slight misnomer, though, because 
it's really an API for people writing serialization libraries — each 
serialization library will have its own API which is what users will 
interact with.) In this way users will be able to chose (or write) a 
serialization library which caters to their particular needs.

So what does this API look like?

## The Serialization API

Basically it's in `ceylon.language.serialization` and if you're contemplating 
writing a serialization library you should have a look at the API docs, but 
to sommarize:

* the `serializable` annotation causes the compiler to generate extra code to 
  allow a class to be decomposed and accessed via the rest of the API.

* a `SerializationContext` holds the necessary information used during 
  serialization. 
    * It provides a single method to get the `references()` of a 
      given instance. 
    * The returned `References` can be iterated and 
      each `ReachableReference` is either a `Member`, an `Element` 
      (if the instance was an array) or an `Outer` (if the instance was a 
      member class). 
    * The returned reference can then be passed back to the 
      `SerializationContext` to get *its* references. Thus we have an API for 
      traversing the instance graph. 
    * It's up to the client (that is, the serialization library) to cope with 
      reference cycles. If it uses simple recursion then cycles will result in a stack overflow, but that might be 
      aceptable for some use cases. 
    * Note that the serialization half of the API doesn't mention ids at all. 
      It's entirely the serialization libraries to find/allocate ids as it 
      needs them, and the externalise the information gained by traversing 
      the object graph. 
      Usually such "externalising" means writing to a file or socket.

* a `DeserializationContext` holds the information used during 
  deserialization. 
    * Each method on that interface represents a single specific 
      bit of information about an instance identified by some `Id`.
    * For example the `instance()` method tells the 
      `DeserializationContext` that class that a particular instance has.
    * The `attribute()` method tells it that a particular instance has a 
      reference via a particular attribute to some other instance.
    * These methods can be called in any order.
    * Thus the serialization library's deserialize "just" has to read 
      bytes and feed the `DeserializationContext` these bits of information.
    * Finally `reconstruct()` causes the `DeserializationContext` to 
      reconstruct a particular object.

## Serialization Libraries

Well, librar**y**, because right now there's only one. It's aiming for a 
middle ground in serializing a broach range of Ceylon classes to JSON with 
as natural a JSON representation as possible, being reasonably configurable 
and with reasonable performance.

Hopefully given a little time, other serialization libraries will be written 
by the community.
