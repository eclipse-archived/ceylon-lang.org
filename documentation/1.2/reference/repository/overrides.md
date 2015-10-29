---
layout: reference12
title_md: Module overrides
tab: documentation
unique_id: docspage
author: Stéphane Épardaud
doc_root: ../..
---

# #{page.title_md}

## Resolving module conflicts

Sometimes module descriptors are not correct, especially when dealing with interop and Maven, but
sometimes you may even want to override Ceylon module descriptors at compile-time or run-time.

Maven module descriptors are notoriously unchecked, and so a lot of module descriptors will miss direct
dependencies because they happen to compile and run by accident when using Maven, which uses a flat
classpath containing all the transitive module dependencies. Ceylon uses `ClassLoader` isolation, and
as such needs module descriptors to be correct. Also Maven does not support the notion of _sharing_
module imports, so if a module `A` makes types from its imported module `B` visible to the users of
`A`, the import of `B` must be made `shared`. Furthermore, Maven supports module version conflict resolution
by design, luck or overrides, while Ceylon uses strict module version imports. And last but not least,
Maven modules frequently bundles things that should not be made visible, such as other modules or tests,
that you may want to exclude.

For all these reasons, we created an experimental measure that lets you override Maven or Ceylon module descriptors
in a single location, called the `overrides.xml` file, which lets you:

- define constants and use them in interpolated XML attributes
- set a module version (for all modules)
- replace a module by another module (for all modules)
- remove a module (for all modules)
- add/remove module dependencies (per module)
- edit a module dependency, for example making it `shared` (per module)
- include/exclude parts of the jar (for example, to exclude certain packages from a jar)

The syntax is as follows:

<!--lang: xml -->
    <overrides>
        <!-- Define a constant to be used in expressions -->
        <define name="restletVersion" value="2.0.10"/>
        <!-- Replace all versions of weld with version 1.1.4.Final -->
        <set groupId="org.jboss.weld" artifactId="weld-osgi-bundle" version="1.1.4.Final"/>
        <!-- Remove all uses of a module -->
        <remove groupId="org.jboss.weld" artifactId="weld-osgi-bundle"/>
        <!-- Edit dependencies of org.restlet.jse:org.restlet/2.0.10 -->
        <artifact groupId="org.restlet.jse" artifactId="org.restlet" version="${restletVersion}">
            <!-- Add/replace a dependency -->
            <add groupId="org.slf4j" artifactId="slf4j-api" version="1.6.1" shared="true"/>
            <!-- Remove a dependency -->
            <remove groupId="org.osgi" artifactId="org.osgi.core" version="4.0.0"/>
            <!-- Share a dependency -->
            <share groupId="org.slf4j" artifactId="slf4j-impl"/>
        </artifact>
        <!-- Replace all uses of org.apache.camel:camel-core/2.9.2 with version 2.10 -->
        <replace groupId="org.apache.camel" artifactId="camel-core" version="2.9.2">
            <with groupId="org.apache.camel" artifactId="camel-core" version="2.10"/>
        </replace>
        <!-- Edit dependencies of org.osgi:org.osgi.core/4.0.0 -->
        <artifact groupId="org.osgi" artifactId="org.osgi.core" version="4.0.0">
            <!-- Only include org/osgi/** and META-INF/** -->
            <filter>
                <!-- You can include or exclude and the matching is in sequence and stops at the first match -->
                <include path="org/osgi/**"/>
                <include path="META-INF/**"/>
                <exclude path="**"/>
            </filter>
        </artifact>
    </overrides>

Most command-line commands accept the `--overrides` argument to specify this file.

## Overrides file syntax

The overrides file must be a valid XML file, with a root named `overrides` 
or `maven-overrides` (the root name is ignored in fact), and containing any of
the following elements:

### Artifact coordinates or module names

Every element that works on modules accepts the following XML attributes:

- `groupId`: for Maven artifact/group pairs (the `artifactId` is also required then)
- `artifactId`: for Maven artifact/group pairs (the `groupId` is also required then)
- `module`: for Ceylon module names
- `version`: an optional artifact/module version which will match every version if missing

### Defining constants

You define constants with the `define` element:

<!--lang: xml -->
    <define name="version" value="2.0.10"/>

And you use them in any subsequent XML attribute with the `${constantName}` syntax:

<!--lang: xml -->
    <remove module="com.foo.bar" version="${version}"/>

### Removing a module entirely

You can remove a module entirely from every import:

<!--lang: xml -->
    <remove module="com.foo.bar"/>

This element accepts the common [Artifact coordinates or module names](#artifact_coordinates_or_module_names) attributes.

### Overriding a module version globally

You can replace every import of a given module to use a specific version:

<!--lang: xml -->
    <set module="com.foo.bar" version="2"/>

This element accepts the common [Artifact coordinates or module names](#artifact_coordinates_or_module_names) attributes.

### Replacing a module globally

You can replace every import of a given module to use another module:

<!--lang: xml -->
    <replace module="com.foo.bar" version="2">
        <with module="com.foo.gee" version="3">
    </replace>

These elements accept the common [Artifact coordinates or module names](#artifact_coordinates_or_module_names) attributes.

### Overriding a single module's dependencies

You can add/replace/remove or share dependencies of a single module:

<!--lang: xml -->
    <module module="com.foo.bar" version="2">
        <!-- this will add or replace existing dependencies -->
        <add module="com.foo.gee" version="3">
        <remove module="com.foo.baz">
        <share module="com.foo.dep">
    </module>

Or for Maven artifacts:

<!--lang: xml -->
    <artifact groupId="com.foo" artifactId="bar" version="2">
        <!-- this will add or replace existing dependencies -->
        <add groupId="com.foo" artifactId="gee" version="3">
        <remove groupId="com.foo" artifactId="baz">
        <share groupId="com.foo" artifactId="dep">
    </artifact>

These elements accept the common [Artifact coordinates or module names](#artifact_coordinates_or_module_names) attributes.

### Filtering a single module's contents

Sometimes modules include classes you do not want to be seen at runtime,
in the metamodel for example, as they are debug/test classes with missing
dependencies. You can also exclude them with this:

<!--lang: xml -->
    <artifact groupId="org.osgi" artifactId="org.osgi.core" version="4.0.0">
        <!-- Only include org/osgi/** and META-INF/** -->
        <filter>
            <!-- You can include or exclude and the matching is in sequence and stops at the first match -->
            <include path="org/osgi/**"/>
            <include path="META-INF/**"/>
            <exclude path="**"/>
        </filter>
    </artifact>

