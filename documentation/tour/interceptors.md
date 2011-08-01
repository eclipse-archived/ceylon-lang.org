---
layout: tour
title: Tour of Ceylon&#58; Interceptors
tab: documentation
author: Gavin King
---

# #{page.title}

An interceptor allows frameworks to react to events like method invocations, 
class instantiations, or attribute evaluations. We don't need to write any 
special annotation scanning code to make use of interceptors. Ceylon handles 
this for us at class-loading time.

All we need to do is have our `Transactional` class implement the interfaces `MethodAnnotation` and `AttributeAnnotation`:

<pre class="brush: ceylon">
shared class Transactional(Boolean requiresNew)
        satisfies OptionalAnnotation<Transactional,Member<Bottom,Void>> &
                  MethodAnnotation & AttributeAnnotation {
         
    shared Boolean requiresNew = requiresNew;
     
    doc "This method is called whenever Ceylon loads a class with a method
         annotated |transactional|. It registers a transaction management
         interceptor for the method."
    shared actual void onDefineMethod<Instance,Result,Argument...>(OpenMethod<Instance,Result,Argument...> method) {
        method.intercept()
                onInvoke(Instance instance, Result proceed(Argument... args), Argument... args) {
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
    }
     
    doc "This method is called whenever Ceylon loads a class with an attribute
         annotated |transactional|. It registers a transaction management
         interceptor for the attribute."
    shared actual void onDefineAttribute<Instance,Result>(OpenAttribute<Instance,Result> attribute) {
        attribute.intercept()
                onGet(Instance instance, Result proceed()) {
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
    }
     
}
</pre>

The `intercept()` method registers the interceptor - a kind of callback method. 
Again, we're using the syntax discussed XXXXX.



