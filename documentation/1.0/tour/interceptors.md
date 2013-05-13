---
layout: tour
title: Tour of Ceylon&#58; Interceptors
tab: documentation
unique_id: docspage
author: Gavin King
doc_root: ../..
---

# #{page.title}

This is the final part of the Tour of Ceylon. The [previous part](../annotations) 
dissected annotations. This part covers Ceylon's support for *interceptors*.

### implementation note <!-- m-later -->

Interceptors and metaprogramming are not yet implemented. They will probably be 
implemented in Ceylon 1.1.

## Interceptors

An interceptor allows frameworks to react to events like method invocations, 
class instantiations, or attribute evaluations. We don't need to write any 
special annotation scanning code to make use of interceptors. Ceylon handles 
this for us at class-loading time.

All we need to do is have our `Transactional` class implement the interfaces 
`MethodAnnotation` and `AttributeAnnotation`:

<!-- try: -->
<!-- check:none: Not supported yet -->
    shared class Transactional(Boolean requiresNew)
            satisfies OptionalAnnotation<Transactional,Member<Nothing,Anything>> &
                      MethodAnnotation & AttributeAnnotation {
             
        shared Boolean requiresNew = requiresNew;
         
        doc "This method is called whenever Ceylon loads a class with a method
             annotated |transactional|. It registers a transaction management
             interceptor for the method."
        shared actual void onDefineMethod<Instance,Result,Argument...>(OpenMethod<Instance,Result,Argument...> method) {
            method.intercept {
                function onInvoke(Instance instance, Result proceed(Argument... args), Argument... args) {
                    if (currentTransaction.inProcess || !requiresNew) {
                        return proceed(args);
                    }
                    else {
                        currentTransaction.begin();
                        try {
                            Result result = proceed(args);
                            currentTransaction.commit();
                            return result;
                        }
                        catch (Exception e) {
                            currentTransaction.rollback();
                            throw e;
                        }
                    }
                }
            };
        }
         
        doc "This method is called whenever Ceylon loads a class with an attribute
             annotated |transactional|. It registers a transaction management
             interceptor for the attribute."
        shared actual void onDefineAttribute<Instance,Result>(OpenAttribute<Instance,Result> attribute) {
            attribute.intercept {
                function onGet(Instance instance, Result proceed()) {
                    if (currentTransaction.inProcess || !requiresNew) {
                        return proceed();
                    }
                    else {
                        currentTransaction.begin();
                        try {
                            Result result = proceed();
                            currentTransaction.commit();
                            return result;
                        }
                        catch (Exception e) {
                            currentTransaction.rollback();
                            throw e;
                        }
                    }
                }
            };
        }
         
    }

The `intercept()` method registers the interceptor - a kind of callback method.


## There's more!

Well actually, this was the last leg, so there isn't any more of the *Tour*.
However, there's still lots of scope for you to explore Ceylon on your own.
You should now know enough to start writing Ceylon code for yourself, and start 
getting to know the platform modules.

Alternatively, if you want to keep reading you can peruse the 
[reference documentation](#{page.doc_root}/reference) or (if you're sitting 
comfortably) read the [specification](#{page.doc_root}/#{site.urls.spec_relative}).

