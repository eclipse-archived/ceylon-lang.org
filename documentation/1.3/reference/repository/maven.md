---
layout: reference13
title_md: Legacy repositories
tab: documentation
unique_id: docspage
author: Stéphane Épardaud
doc_root: ../..
---

# #{page.title_md}

Ceylon's module system integrates with Maven repositores, and can obtain
dependencies (Java `jar` archives) from a Maven repository via Aether.

## Maven repositories

Maven modules are seamlessly supported in the Ceylon module descriptor,
but:

- the module name must be quoted, and
- the `:` separator must be used to separate Maven group and artifact ids.

For example:

<!-- try: -->
    import maven:"org.hibernate:hibernate-core" "5.0.4.Final";

### Maven group and artifact ids 

Ceylon uses a single identifier for module names, but Maven uses a _group id_ 
together with an _artifact id_. So to import the Maven module with group id 
`org.hibernate` and artifact id `hibernate-core`, we formed a module name 
by concatenating the two identifiers with a `:` (colon) and quoting 
the resulting identifier, resulting in the module name 
`"org.hibernate:hibernate-core"` seen above.

### Specifying explicit Maven settings 

If you have special requirements and need a specific Maven `setting.xml`, 
you can specify the file using the `rep` flag:

<!--lang: none -->
    ceylon compile --rep aether:/path/to/special/setting.xml com.example.foo

### Resolving Maven conflicts

Very often, when working with legacy Maven repositories, we encounter one or
all of:

- versioning conflicts,
- undeclared dependencies, or
- the need to export promote transitive dependencies.

These problems arise from the fact that Maven metadata is often only tested
with a flat classpath, and breaks when executing on isolated classloaders in
Ceylon.

In such scenarios, there are two main ways to proceed:

- run your Ceylon program on a flat classpath, using the `--flat-classpath`
  flag of the command line tools, or
- use a [module overrides](../overrides) file to resolve the problems
  individually by adjusting the module dependencies.  
