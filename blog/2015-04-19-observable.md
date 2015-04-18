---
title: Unique approach to observer/observable pattern in Ceylon
author: Gavin King
layout: blog
unique_id: blogpage
tab: blog
tags:
---

The essence of the famous observer/observable pattern is that
you have an _observable_ object that produces _events_ of
various kinds, and one or more _observer_ objects that register
themselves as interested in notification when these events
occur.

Of course, we represent each kind of event as a type, usually
a class, though nothing prevents us from using an interface
type as an event type.

For example:

<!-- try: -->
    class Started() {}
    class Stopped() {}

An event type may even be generic:

<!-- try: -->
    class Created<out Entity>
            (shared Entity entity) 
            given Entity satisfies Object {
        string => "Created[``entity``]";
    }
    
    class Updated<out Entity>
            (shared Entity entity) 
            given Entity satisfies Object {
        string => "Updated[``entity``]";
    }
    
    class Deleted<out Entity>
            (shared Entity entity) 
            given Entity satisfies Object {
        string => "Deleted[``entity``]";
    }

Of course, we have powerful mechanisms for abstracting over
event types, for example:

<!-- try: -->
    alias Lifecycle<Entity> 
            given Entity satisfies Object
            => Created<Entity> |
               Updated<Entity> |
               Deleted<Entity>;

An observer, usually, is in essence nothing more than a 
function that accepts a certain type of event as a parameter.

For example, this anonymous function observes the creation
or `User`s:

<!-- try: -->
    (Created<User> userCreated) 
            => print("new user created: " + userCreated.entity.name)

This anonymous function observes lifecycle events of any 
kind of entity:

<!-- try: -->
    (Lifecycle<Object> event) 
            => print("something happened: " + event)

In Ceylon, union and intersection types give us a nice way
to express conjunction and disjunction of event types:

<!-- try: -->
    void (Created<User>|Deleted<User> userEvent) {
        switch (userEvent)
        case (is Created<User>) {
            print("user created: " + userEvent.entity.name);
        }
        case (is Deleted<User>) {
            print("user deleted: " + userEvent.entity.name);
        }
    }

Now here's where we can do something really cute. Typically,
in other languages, the observable object provides various
observer registration operations, one for each kind of event
the object produces. We're going to define a generic class
`Observable` that works for any event type, and uses reified
generics to map events to observer functions.

<!-- try: -->
    shared class Observable<in Event>() 
            given Event satisfies Object {
        ...
    }

The type parameter `Event` captures the various kinds of 
events that this object produces, for example, an
`Observable<Lifecycle<User>>` produces events of type 
`Created<User>`, `Updated<User>`, and `Deleted<User>`.

We need a list to store observers in:

<!-- try: -->
    value listeners = ArrayList<Anything(Nothing)>();

Here, `Anything(Nothing)` is the supertype of any function
with one parameter.

The `addObserver()` method registers an observer function
with the `Observable`:

<!-- try: -->
    shared void addObserver<ObservedEvent>
            (void handle(ObservedEvent event))
            given ObservedEvent satisfies Event
            => listeners.add(handle);

This method only accepts observer functions for some subset
of the events actually produced by the `Observable`.

The `raise()` method produces an event:

<!-- try: -->
    shared void raise<RaisedEvent>(RaisedEvent event)
            given RaisedEvent satisfies Event
            => listeners.narrow<Anything(RaisedEvent)>()
                .each((handle) => handle(event));

This function uses the new `narrow()` method of `Iterable`
in Ceylon 1.2 to filter out observer functions that don't
accept the raised event type. This method is implemented
using reified generics. Here's its definition in 
`Iterable<Element>`:

<!-- try: -->
    shared default {Element&Type*} narrow<Type>() 
            => { for (elem in this) if (is Type elem) elem };

Now, finally, if we define an instance of `Observable`:

<!-- try: -->
    object userPersistence 
            extends Observable<Lifecycle<User>>() {
            
        shared void create(User user) {
            ...
            //raise an event
            raise(Created(user));
        }
        
        ...
    }

Then we can register observers for this object like this:

<!-- try: -->
    //observe User creation events
    userPersistence.addObserver(
            (Created<User> userCreated) 
            => print("new user created: " + userCreated.entity.name));
    
    //observe User creation and deletion events
    userPersistence.addObserver(
            void (Created<User>|Deleted<User> userEvent) {
        switch (userEvent)
        case (is Created<User>) {
            print("user created: " + userEvent.entity.name);
        }
        case (is Deleted<User>) {
            print("user deleted: " + userEvent.entity.name);
        }
    });


Notice how with union and intersection types, subtyping, and 
variance, we find ourselves with a powerful expression 
language for specifying exactly which kinds of events we're
interested in, in a typesafe way, right in the parameter
list of the observer function.

For the record, here's the complete code of `Observable`:

<!-- try: -->
    shared class Observable<in Event>() 
            given Event satisfies Object {
        value listeners = ArrayList<Anything(Nothing)>();
        
        shared void addObserver<ObservedEvent>
                (void handle(ObservedEvent event))
                given ObservedEvent satisfies Event
                => listeners.add(handle);
        
        shared void raise<RaisedEvent>(RaisedEvent event)
                given RaisedEvent satisfies Event
                => listeners.narrow<Anything(RaisedEvent)>()
                    .each((handle) => handle(event));
        
    }

Finally, a caveat: the precise code above does not compile 
in Ceylon 1.1, because the `narrow()` method is new, and 
because of a fixed bug in the typechecker. But it will work 
in the upcoming 1.2 release of Ceylon.
  