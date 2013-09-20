---
title: Ceylon IDE
layout: documentation
tab: documentation
unique_id: docspage
author: Gavin King
---
# #{page.title}

[eclipse]: http://www.eclipse.org/downloads/
[juno]: http://eclipse.org/juno

The Ceylon IDE is a plugin for [Eclipse][eclipse]. The IDE project was 
initiated by David Festal from [SERLI](http://www.serli.com/), a french 
software company contributing to the Ceylon project.

<img src="/images/screenshots/teaser.png" style="box-shadow: 0 0 10px #888;margin-left:5px;"/>

## Features

The plugin provides the following features, among others:

* Ceylon perspective with Ceylon Explorer view
* Incremental compilation and interactive error reporting
* Inter-compilation with Java
* Optional compilation to JavaScript
* [Run / Debug](screenshots#ceylon_launcher_dialog) to execute on JVM or Node.js
* [Powerful test framework graphical support](test-plugin)
* Customizable [syntax highlighting](screenshots#syntax_highlighting_and_outline_view)
* [Outline view](screenshots#syntax_highlighting_and_outline_view) 
  and popup outline
* [Popup type hierarchy](screenshots#popup_type_hierarchy)
* [Error reporting in Problems view
  and error annotations in editor](screenshots#error_highlighting_error_annotations_and_problems_view)
* Reporting of `//todo` and `//fix` in Tasks view
  and task annotations in editor
* [Intelligent proposals](screenshots#intelligent_autocompletion)
* [Documentation hover](screenshots#hover_help)
* [Hyperlink navigation](screenshots#hyperlink_navigation) to 
  declarations in Ceylon and Java
* Auto indentation and Correct Indentation
* Ceylon Repository Explorer view
* New wizards: [New Ceylon Source File](screenshots#new_ceylon_unit_wizard),
  [New Ceylon Project](screenshots#new_ceylon_project_wizard),
  [New Ceylon Module](screenshots#new_ceylon_module_wizard), and 
  New Ceylon Package
* [Cross-project dependencies](screenshots#cross_project_dependencies),
  and support for external module repositories
* Multi-project incremental build and cross-project search, 
  navigation, and refactoring
* Export Ceylon Module to Module Repository wizard
* Export Java Archive to Module Repository wizard
* Integration with Ceylon Herd
* [Open Ceylon Declaration dialog](screenshots#open_ceylon_declaration_dialog)
* [Ceylon Search dialog](screenshots#ceylon_search_dialog)
* Find References, Find Refinements, Find Subtypes, and Find Assignments
  [contextual search](screenshots#find_references_search_results)
* Basic [refactoring](screenshots#rename_refactoring_preview): 
  Rename, Inline, Extract Value, Extract Function, and Clean Imports
* More than 30 [Quick Fixes](screenshots#quick_fixes) and Quick Assists!
* Configurable keyboard accelerators
* Code folding, structured compare, mark occurrences, and more...

Check out the [screenshots](screenshots)!

## Running the IDE

You'll need a clean install of [Eclipse 4.3 Kepler][eclipse] or of 
[Eclipse 4.2 Juno][juno] running on Java 7. 

Install Ceylon IDE (which includes the Ceylon compiler) from our 
[Eclipse plugin update site](install).

<!--
You can install Ceylon IDE (which includes the Ceylon compiler) either:

* from our [Eclipse plugin update site](install), or 
* from Eclipse Marketplace by dragging and dropping this button into 
  a running Eclipse Indigo workspace:
  <a href='http://marketplace.eclipse.org/marketplace-client-intro?mpc_install=185799' title='Drag and drop into a running Eclipse Indigo workspace to install Ceylon IDE' style="display:block;text-align:center;font-weight:bold;text-decoration:none"> 
  <img src='http://marketplace.eclipse.org/misc/installbutton.png'/>
  <br/>Ceylon IDE 
  </a>
-->

After installing the plugin, go straight to `Help > Welcome to Ceylon`.
