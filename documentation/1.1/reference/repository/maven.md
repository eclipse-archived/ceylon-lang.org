---
layout: reference11
title_md: Legacy repositories
tab: documentation
unique_id: docspage
author: Stéphane Épardaud
doc_root: ../..
---

# #{page.title_md}

Ceylon integrates with other legacy repositories, such as Maven.

## Maven repositories

Ceylon supports Maven repository layouts, so you can resolve module dependencies
for legacy Java `jar` archives from legacy Maven repositories.

Right now there are two ways of enabling Maven support, the first is using the special "aether"
repository, like this:

<!--lang: none -->
    ceylon compile --rep aether com.example.foo

This is the simplest way and will most likely be enough for most purposes.

If you have special requirements that need a specific Maven `setting.xml` you can point to it:

<!--lang: none -->
    ceylon compile --rep aether:/path/to/special/setting.xml com.example.foo

But there's also another way to enable Maven support that is more limited but that allows you
to specify a specific Maven repository right there on the command line, for example to use
Maven Central you write:

<!-- lang: none -->
    ceylon compile --rep mvn:http://repo1.maven.org/maven2 com.example.foo

**Note:** This way of specifying Maven repositories is limited and does not resolve Maven dependencies,
so you only get the one `jar` you defined as a dependency.

### Group and artifact Ids

Ceylon uses a single identifier for module names, but Maven uses a pair of `groupId` and `artifactId`.
If you want to import the Maven module with `groupId` `org.hibernate` and `artifactId` `hibernate-core`,
then you simply import it by concatenating the two identifiers with a `:` (colon) and quoting the
resulting identifier:

<!-- lang: ceylon-notry -->
    import "org.hibernate:hibernate-core" "4.3.7.Final";

### Resolving Maven conflicts

Maven module descriptors are notoriously unchecked, and so a lot of module descriptors will miss direct
dependencies because they happen to compile and run by accident when using Maven, which uses a flat
classpath containing all the transitive module dependencies. Ceylon uses `ClassLoader` isolation, and
as such needs module descriptors to be correct. Also Maven does not support the notion of _sharing_
module imports, so if a module `A` makes types from its imported module `B` visible to the users of
`A`, the import of `B` must be made `shared`. Furthermore, Maven supports module version conflict resolution
by design, luck or overrides, while Ceylon uses strict module version imports. And last but not least,
Maven modules frequently bundles things that should not be made visible, such as other modules or tests,
that you may want to exclude.

For all these reasons, we created an experimental measure that lets you override Maven module descriptors
in a single location, called the Maven `overrides.xml` file, which lets you:

- replace a module import by another version (for all modules)
- add/remove module dependencies (per module)
- edit a module dependency, for example making it `shared` (per module)
- include/exclude parts of the jar (for example, to exclude certain packages from a jar)

The syntax is as follows:

<!--lang: xml -->
    <maven-overrides>
        <!-- Edit dependencies of org.restlet.jse:org.restlet/2.0.10 -->
        <artifact groupId="org.restlet.jse" artifactId="org.restlet" version="2.0.10">
            <!-- Add/replace a dependency -->
            <add groupId="org.slf4j" artifactId="slf4j-api" version="1.6.1" shared="true"/>
            <!-- Remove a depdendency -->
            <remove groupId="org.osgi" artifactId="org.osgi.core" version="4.0.0"/>
        </artifact>
        <!-- Replace all uses of org.apache.camel:camel-core/2.9.2 with version 2.10 -->
        <artifact groupId="org.apache.camel" artifactId="camel-core" version="2.9.2">
            <replace groupId="org.apache.camel" artifactId="camel-core" version="2.10"/>
        </artifact>
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
    </maven-overrides>

You can specify Maven overrides on the command-line with the `--maven-overrides` flag.