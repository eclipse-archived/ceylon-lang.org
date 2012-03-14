---
layout: reference
title: Ceylon Ant tasks
tab: documentation
unique_id: docspage
author: Tom Bentley
doc_root: ../../..
---

# #{page.title}

## Usage 

Before using any of the Ceylon [Ant](http://ant.apache.org) 
tasks they need to be declared using a `<taskdef>`:

<!-- lang: xml -->
    <target name="ceylon-ant-taskdefs">
      <path id="ant-tasks">
        <pathelement location="${ceylon.ant.lib}"/>
      </path>
      <taskdef name="ceylonc" 
        classname="com.redhat.ceylon.ant.Ceylonc" 
        classpathref="ant-tasks"/>
      <taskdef name="ceylond" 
        classname="com.redhat.ceylon.ant.Ceylond" 
        classpathref="ant-tasks"/>
      <taskdef name="ceylon" 
        classname="com.redhat.ceylon.ant.Ceylon" 
        classpathref="ant-tasks"/>
    </target>

## See also

* The [`<ceylonc>`](../ant-ceylonc) task
* The [`<ceylond>`](../ant-ceylond) task
* The [`<ceylon>`](../ant-ceylon) task
