---
layout: reference12
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

Maven modules are seamlessly supported by Ceylon, provided you use the `:` separator in the module name:

<!-- lang: ceylon-notry -->
    import "org.hibernate:hibernate-core" "4.3.7.Final";

If you have special requirements that need a specific Maven `setting.xml` you can point to it:

<!--lang: none -->
    ceylon compile --rep aether:/path/to/special/setting.xml com.example.foo

### Group and artifact Ids

Ceylon uses a single identifier for module names, but Maven uses a pair of `groupId` and `artifactId`.
If you want to import the Maven module with `groupId` `org.hibernate` and `artifactId` `hibernate-core`,
then you simply import it by concatenating the two identifiers with a `:` (colon) and quoting the
resulting identifier:

<!-- lang: ceylon-notry -->
    import "org.hibernate:hibernate-core" "4.3.7.Final";

### Resolving Maven conflicts

[See Module Overrides](../overrides)