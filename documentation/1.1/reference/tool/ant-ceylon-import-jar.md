---
layout: reference11
title_md: '`<ceylon-import-jar>` Ant task'
tab: documentation
unique_id: docspage
author: Tako Schotanus
doc_root: ../../..
---

# #{page.title_md}

## Usage 

**Note**: You must [declare the tasks with a `<typedef>`](../ant).

To import the `example-foo-1.1.jar` file in a Ceylon repository residing
in the `build` directory as version 1.1 of module `com.example.foo`:

<!-- lang: xml -->
    <target name="import" depends="ceylon-ant-taskdefs">
      <ceylon-import-jar jar="example-foo-1.1.jar" 
        module="com.example.foo/1.1">
        <rep url="build"/>
      </ceylon-import-jar>
    </target>

## Description

The `<ceylon-import-jar>` ant task makes it possible to import a legacy Java jar file into
a Ceylon repository as a module. Dependencies for the imported module can be specified
by making use of module descriptor XML or property files which are described in the section
on [legacy modules](../../structure/module/#legacy_modules).

### Parameters

<table class="ant-parameters">
<tbody>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Required</th>
</tr>

<tr>
<td id="param-module"><code>module</code></td>
<td>The module and version to use for the imported jar file. Ex: `com.example.foo/1.1`.</td>
<td>Yes</td>
</tr>

<tr>
<td><code>jar</code></td>
<td>The path to the jar file to import. Ex: `lib/example-foo-1.1.jar`.</td>
<td>Yes</td>
</tr>

<tr>
<td id="param-descriptor"><code>descriptor</code></td>
<td>A path to an optional desciptor XML or properties file.</td>
<td>No</td>
</tr>

<tr>
<td><code>out</code></td>
<td>The output module repository (which must be publishable).</td>
<td>No, default is <i>modules</i></td>
</tr>

<tr>
<td><code>user</code></td>
<td>The user name to use when connecting to the output repository. Only used for HTTP output repositories.</td>
<td>No</td>
</tr>

<tr>
<td><code>pass</code></td>
<td>The password to use when connecting to the output repository. Only used for HTTP output repositories.</td>
<td>No</td>
</tr>

<tr>
<td><code>verbose</code></td>
<td>Whether the documentation generator should emit verbose logging information. The zero or more of the
following flags can be passed separated by commas: 'all' or 'loader'.
If you do not pass a flag 'all' will be assumed.</td>
<td>No</td>
</tr>

</tbody>
</table>

## See also

* How to [declare the tasks with a `<typedef>`](../ant).
* Descriptor files for [legacy modules](../../structure/module/#legacy_modules)

