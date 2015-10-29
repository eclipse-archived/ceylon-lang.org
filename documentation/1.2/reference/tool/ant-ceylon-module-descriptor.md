---
layout: reference12
title_md: '`<ceylon-module-descriptor>` Ant task'
tab: documentation
unique_id: docspage
author: Tako Schotanus
doc_root: ../../..
---

# #{page.title_md}

## Usage 

**Note**: You must [declare the tasks with a `<typedef>`](../ant).

To retrieve the name, version and license information from the sources
for module `com.example.foo` and exposing them as ant properties:

<!-- lang: xml -->
    <target name="descriptor" depends="ceylon-ant-taskdefs">
      <ceylon-module-descriptor
            src="src"
            module="com.example.foo"
            name="modulename"
            version="moduleversion"
            license="modulelicense"
      />
      <echo message="Name ${modulename}" />
      <echo message="Version ${moduleversion}" />
      <echo message="License ${modulelicense}" />
    </target>

## Description

The `<ceylon-module-descriptor>` ant task supports retrieving
the name, version and license from a module descriptor and making
them available as properties for the ant build file. If no name
is given for the different properties that can be retrieved then
that particular attribute from the descriptor will not be available
to the build script.

### Parameters

**Note**: In contrast to almost all other Ceylon ant tasks this one
does not support any of the "common" attributes as listed on the main
tool page.

<table class="ant-parameters">
<tbody>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Required</th>
</tr>

<tr>
<td><code>src</code></td>
<td>A source directory.</td>
<td>No, default is <i>source</i></td>
</tr>

<tr>
<td id="param-module"><code>module</code></td>
<td>The module name whose descriptor file we want to read. Ex: `com.example.foo`.</td>
<td>Yes</td>
</tr>

<tr>
<td><code>name</code></td>
<td>The name of the property in which to store the module's name.</td>
<td>No</td>
</tr>

<tr>
<td><code>version</code></td>
<td>The name of the property in which to store the module's version.</td>
<td>No</td>
</tr>

<tr>
<td><code>license</code></td>
<td>The name of the property in which to store the module's license.</td>
<td>No</td>
</tr>

</tbody>
</table>

## See also

* How to [declare the tasks with a `<typedef>`](../ant).

