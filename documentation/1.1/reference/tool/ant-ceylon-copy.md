---
layout: reference11
title_md: '`<ceylon-copy>` Ant task'
tab: documentation
unique_id: docspage
author: Tako Schotanus
doc_root: ../../..
---

# #{page.title_md}

## Usage 

**Note**: You must [declare the tasks with a `<typedef>`](../ant).

To copy the module `com.example.foo` with all its dependencies
to a module repository in the `build` directory:

<!-- lang: xml -->
    <target name="copy" depends="ceylon-ant-taskdefs">
      <ceylon-copy out="build" recursive="true">
        <module name="com.example.foo" version="1.5"/>
      </ceylon-compile>
    </target>

## Description

The `<ceylon-compile>` ant task supports copying a module or a set of
modules from one repository to another. If set for recursive copying
it will also copy all the module's dependencies and their dependencies
until the entire module tree has been copied.

### Parameters

**Note**: In addition to the parameters in the table below, 
a nested [`<module>`](#module)s required.

<table class="ant-parameters">
<tbody>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Required</th>
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
<td><code>recursive</code></td>
<td>A source directory.</td>
<td>No, default is <i>false</i></td>
</tr>

<tr>
<td><code>verbose</code></td>
<td>Whether the compiler should emit verbose logging information. The zero or more of the
following flags can be passed separated by commas: 'all' or 'loader'. If you do not pass
a flag 'all' will be assumed.</td>
<td>No</td>
</tr>

</tbody>
</table>

### Nested elements

#### `<moduleset>`

A reference to a [`<moduleset>`](../ant#reposet) defined elsewhere in the 
ant build file. 

#### `<module>`

A module to compile. Can be specified multiple times.

<table class="ant-parameters">
<tbody>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Required</th>
</tr>

<tr>
<td><code>name</code></td>
<td>The module name</td>
<td>Yes</td>
</tr>

</tbody>
</table>

#### `<reposet>`
A reference to a [`<reposet>`](../ant#reposet) defined elsewhere in the 
ant build file. 

#### `<rep>`
A module repository containing dependencies. Can be specified multiple times. Defaults to `modules`.

<table class="ant-parameters">
<tbody>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Required</th>
</tr>

<tr>
<td><code>url</code></td>
<td>The URL of the module repository</td>
<td>Yes</td>
</tr>

</tbody>
</table>

## See also

* How to [declare the tasks with a `<typedef>`](../ant).

