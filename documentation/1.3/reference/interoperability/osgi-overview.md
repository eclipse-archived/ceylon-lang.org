---
layout: reference13
title_md: Ceylon and OSGi
tab: documentation
unique_id: docspage
author: David Festal
---

# #{page.title_md}

Ceylon modules may be deployed in an OSGi container, and may
interoperate with native OSGi modules. For example, Ceylon IDE
for Eclipse is partially written in Ceylon, and integrates with 
the Eclipse environment using OSGi.

### Installing the Ceylon distribution and SDK in an OSGi container

In order to be able to resolve and start Ceylon module archives 
(`.car` files) inside an OSGi container, you will first need to 
install, in the OSGi container, all the bundles of the Ceylon 
distribution and SDK.

These bundles are available in a dedicated location on the 
Ceylon language web site under various delivery forms:

- OSGi bundle repositories (OBR and R5 XML), for Felix-based 
  containers for example,
- P2 repositories for Eclipse development or deployment to 
  an Equinox container,
- Zip archives for direct deployment inside containers,
- Apache Karaf (aka JBoss Fuse) 
  [features](http://karaf.apache.org/manual/latest/users-guide/provisioning.html).

The OSGi interoperability reference gives more details about the 
[URLs providing these packages](../osgi#retrieving_the_ceylon_distribution_and_sdk_for_osgi), 
as well as 
[how to install](../osgi#installing_the_ceylon_distribution_and_sdk_in_an_osgi_container) 
these bundles, for various containers.

### OSGi metadata management

[Module archives](./modules#module_archives_and_module_repositories) 
generated for execution on the Java virtual machine already 
contain the OSGi metadata that can be deduced from the Ceylon 
module descriptor.

More precisely, for the following module descriptor:

<!-- try: -->
    native("jvm") module example.pureCeylon "3.1.0" {
        import ceylon.locale "1.2.2";
        import java.base "7";
        shared import ceylon.net "1.2.2";
    }

the following OSGi metadata will be automatically generated 
in the module archive `META-INF/MANIFEST.MF` entry:

<!-- try: -->
    Bundle-SymbolicName: example.pureCeylon
    Bundle-Version: 3.1.0.v20160311-1742
    Export-Package: example.pureCeylon;version=3.1.0
    Require-Bundle: com.redhat.ceylon.dist;bundle-version=1.2.2;visibility
     :=reexport,ceylon.locale;bundle-version=1.2.2,ceylon.net;bundle-versi
     on=1.2.2;visibility:=reexport,ceylon.language;bundle-version=1.2.2;vi
     sibility:=reexport
    Require-Capability: osgi.ee;filter:="(&(osgi.ee=JavaSE)(version>=1.7))"

The Ceylon module imports are translated into a `Require-Bundle` 
header, and `shared` imports are translated into a `reexport` 
directive. The `java.base "7"` import is translated into a 
`Require-Capability` header that requires the same Java version.

Note that the `com.redhat.ceylon.dist` bundle is systematically 
and implicitly added as a dependency to all generated Ceylon 
archives.

However it is also possible to customize the OSGi metadata of 
the generated archive in two ways:

1. Additional manifest entries or resources (such as a 
   declarative service descriptor) can be added by simply adding 
   resources as explained [below](#meta_inf_and_web_inf).
2. Module imports that correspond to __dependencies provided 
   by the OSGi container__ (such as the OSGi framework bundle 
   or any bundle assumed to be available in the OSGi container) 
   should be omitted from the generated `Require-Bundle` header. 
   The `--osgi-provided-bundles=<modules>` option of the 
   `ceylon compile` command allows specifying those modules. 
   The same list can also be specified in the 
   [compiler section](http://www.ceylon-lang.org/documentation/1.2/reference/tool/config#_compiler_section) 
   of the configuration file.
  
Generally, once omitted from the `Require-Bundle` header, 
the dependencies to provided bundles should be declared in 
an `Import-Package` header added in the 
[`MANIFEST.MF` resource](#meta_inf_and_web_inf), as mentioned 
in point 1.
 
### Ceylon metamodel registration

In order to be able to fully leverage the power of the Ceylon 
language, the metamodel should be initialized for each module 
used by a Ceylon application. It is automatically performed 
when running from the command line through the `ceylon run` 
command, but in an OSGi container it should be done when 
starting the Ceylon module. The Ceylon OSGi distribution 
provides an easy way to register the metamodel for a module, 
as well as for all the modules transitively imported.

This can be done by adding an OSGi activator class to the 
Ceylon module, that performs this metamodel registration. 
The `com.redhat.ceylon.dist` OSGi bundle, implicitly 
required by all Ceylon modules, already provides such an 
activator class: `com.redhat.ceylon.dist.osgi.Activator`.

So if you don't need to do anything else in your OSGi Ceylon 
bundle at startup, you can simply add the following line to 
your [`MANIFEST.MF` resource](#meta_inf_and_web_inf):

<!-- try: -->
    Bundle-Activator: com.redhat.ceylon.dist.osgi.Activator

Alternatively, if you need to perform some sort initialization 
in your Ceylon module bundle startup, you can also define an 
`Activator` class that will delegate to the default 
`com.redhat.ceylon.dist.osgi.Activator`. In this case, you'll 
need to follow these three steps.

First, explicitly import the `com.redhat.ceylon.dist` module
in your module descriptor:

<!-- try: -->
    native("jvm") module example.withActivator "1.0.0" {
        shared import com.redhat.ceylon.dist "1.2.2";
        import java.base "7";
    }

Next, add the following class to your module:

<!-- try: -->
    import com.redhat.ceylon.dist.osgi {
        DefaultActivator = Activator
    }
    import org.osgi.framework {
        BundleContext
    }
    
    shared class Activator() extends DefaultActivator() {
        shared actual void start(BundleContext context) {
            // do module startup stuff
            super.start(context); // perform the metamodel registration
        }
        shared actual void stop(BundleContext context) {
            // do module shutdown stuff
            super.stop(context);
        }
    }

Finally, Add the following line to your 
`example/withActivator/ROOT/META-INF/MANIFEST.MF` resource:

<!-- try: -->
    Bundle-Activator: example.withActivator.Activator
