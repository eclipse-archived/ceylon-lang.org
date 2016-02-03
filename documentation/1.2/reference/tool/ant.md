---
layout: reference12
title_md: Ceylon Ant tasks
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title_md}

## Usage 

Before using any of the Ceylon [Ant](http://ant.apache.org) 
tasks they need to be declared using a `<typedef>`:

<!-- lang: xml -->
    <property name="ceylon.ant.lib" value="${ceylon.home}/lib/ceylon.ant.jar"/>
    
    <target name="ceylon-ant-taskdefs">
      
      <!-- Create a path to the ceylon-ant.jar --> 
      <path id="ant-tasks">
        <pathelement location="${ceylon.ant.lib}"/>
      </path>
    
      <!-- use a typedef to define all the ceylon tasks together -->
      <typedef resource="com/redhat/ceylon/ant/antlib.xml" classpathref="ant-tasks"/>
      
    </target>

**Note:** Prior to M5 we used a `<taskdef>`, but such usage is now deprecated.

### Common parameters

<table class="ant-parameters">
<tbody>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Required</th>
</tr>

<tr>
<td><code>cwd</code></td>
<td>Set the current directory for the task to the given path.</td>
<td>No</td>
</tr>

<tr>
<td><code>sysrep</code></td>
<td>Set the system repository to the given directory.</td>
<td>No, the default is <i>$CEYLON_HOME/repo</i>.</td>
</tr>

<tr>
<td><code>cacherep</code></td>
<td>Set the cache repository to the given directory.</td>
<td>No, the default is <i>~/.ceylon/cache</i>.</td>
</tr>

<tr>
<td><code>nodefaultrepository</code></td>
<td>When set none of the default repositories will be used by the module resolver,
all of them will have to be specified manually using &lt;rep&gt; and/or &lt;reposet&gt;.</td>
<td>false</td>
</tr>

</tbody>
</table>


### Common nested elements

#### `<reposet>`

A `<reposet>` element contains a number of `<repo>` and/or `<reposet>` elements. 
It can be defined at the 
top level, and then used by reference in `<ceylon-*>` tasks so you don't have 
to repeat the same list of repositories all the time. 

Here's an example from the `build.xml` for the Ceylon SDK:

<!-- lang: xml -->
    <reposet id="reposet.compile.test">
        <repo url="${out.repo}"/>
        <repo url="test-deps"/><!-- Needed for h2.jar dep of test.ceylon.dbc -->
    </reposet>
    
    <!-- ... -->
    
    <target name="compile-test-jvm" depends="compile-jvm">
        
        <ceylon-compile executable="${ceylon.executable}"
            src="test-source"
            out="${test.repo}"
            verbose="${ceylon.verbosity}"
            encoding="UTF-8">
            <reposet refid="reposet.compile.test"/> 
            <moduleset refid="modules.test.jvm"/>
        </ceylon-compile>
        
    </target>


#### `<moduleset>`

A `<moduleset>` element contains a number of `<sourcemodules>` and/or `<module>`
elements. It can be defined at the 
top level, and then used by reference in `<ceylon-*>` tasks so you don't have 
to repeat the same list of modules all the time. 

A `<sourcemodules>` element simply includes all the ceylon modules in a given 
source directory, as specified by its `dir` attribute. This saves you having 
to explicitly list all the modules to be compiled, you can instead just 
compile all the modules in a given directory.

Here's an example using `<moduleset>`/`<sourcemodules>`from the 
`build.xml` for the Ceylon SDK:

<!-- lang: xml -->
    <moduleset id="modules.sdk.jvm">
        <sourcemodules dir="source"/>
    </moduleset>
    
    <!-- ... -->
    
    <target name="compile-jvm">
        
        <ceylon-compile executable="${ceylon.executable}"
            verbose="${ceylon.verbosity}"
            encoding="UTF-8">
            <moduleset refid="modules.sdk.jvm"/>
        </ceylon-compile>
        
    </target>

A `<module>` element must specify a name, and may specify a version. 
If the relevant ceylon task don't require a version it will be ignored. 

Here's an example using `<moduleset>`/`<module>`from the 
`build.xml` for the Ceylon SDK:

<!-- lang: xml -->
    <moduleset id="modules.sdk.js">
        <module name="ceylon.test"/>
        <module name="ceylon.collection"/>
        <module name="ceylon.json"/>
    </moduleset>

    <!-- ... -->
    
    <target name="compile-js">
        
        <ceylon-compile-js executable="${ceylon.executable}"
            verbose="${ceylon.verbosity}"
            encoding="UTF-8">
            <moduleset refid="modules.sdk.js"/>
        </ceylon-compile-js>
        
    </target>



#### `<define>`

A `<define>` element is used to set system properties for the ant task being
executed. It can be used as a child element for any of the Ceylon ant tasks.
The value for the property can either be passed as a `value` attribute as
described below or it can be the text between the begin and end tags or
it is even posible to dispense with the attributes and use the syntax `key=value`.

<table class="ant-parameters">
<tbody>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Required</th>
</tr>

<tr>
<td><code>key</code></td>
<td>The name of the property to pass</td>
<td>No</td>
</tr>

<tr>
<td><code>value</code></td>
<td>The value of the property to pass</td>
<td>No</td>
</tr>

</tbody>
</table>


## See also

* The [`<ceylon-compile>`](../ant-ceylon-compile) task
* The [`<ceylon-doc>`](../ant-ceylon-doc) task
* The [`<ceylon-run>`](../ant-ceylon-run) task
* The [`<ceylon-compile-js>`](../ant-ceylon-compile-js) task
* The [`<ceylon-run-js>`](../ant-ceylon-run-js) task
* The [`<ceylon-import-jar>`](../ant-ceylon-import-jar) task
* The [`<ceylon-module-descriptor>`](../ant-ceylon-module-descriptor) task
* The [`<ceylon-copy>`](../ant-ceylon-copy) task
* The [`<ceylon-war>`](../ant-ceylon-war) task

