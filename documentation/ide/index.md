---
title: Ceylon IDE
layout: documentation
tab: documentation
unique_id: docspage
author: Gavin King
---
# #{page.title}

The Ceylon IDE is a plugin for [Eclipse](http://eclipse.org). The IDE project 
was initiated by David Festal from [SERLI](http://www.serli.com/), a french 
software company contributing to the Ceylon project.

![teaser](/images/screenshots/teaser.png)

## Features

The plugin provides the following features, among others:

* Incremental compilation
* [Run / Debug](screenshots#ceylon_launcher_dialog)
* [Syntax highlighting](screenshots#syntax_highlighting_and_outline_view)
* [Outline view](screenshots#syntax_highlighting_and_outline_view) 
  and popup outline
* [Popup type hierarchy](screenshots#popup_type_hierarchy)
* [Error reporting in Problems view
  and error annotations in editor](screenshots#error_highlighting_error_annotations_and_problems_view)
* Reporting of `//todo` and `//fix` in Tasks view
  and task annotations in editor
* [Intelligent proposals](screenshots#intelligent_autocompletion)
* [Documentation hover](screenshots#hover_help)
* [Hyperlink navigation](screenshots#hyperlink_navigation) to declarations
* Auto indentation and Correct Indentation
* [New Ceylon Unit wizard](screenshots#new_ceylon_unit_wizard)
* [New Ceylon Module](screenshots#new_ceylon_module_wizard) and New Ceylon Package wizards
* Export Ceylon Module to Module Repository wizard
* [Open Ceylon Declaration dialog](screenshots#open_ceylon_declaration_dialog)
* [Ceylon Search dialog](screenshots#ceylon_search_dialog)
* Find References, Find Refinements, and Find Subtypes 
  [contextual search](screenshots#find_references_search_results)
* Configurable keyboard accelerators
* Basic [refactoring](screenshots#rename_refactoring_preview): 
  Rename, Inline, Extract Value, Extract Function,
  Convert To Named Arguments, and Clean Imports
* Basic [Quick Fixes](screenshots#quick_fixes): 
  rename reference, create member declaration, create local 
  declaration, add import, make shared, make actual, make default, 
  specify type, refine formal members
* Clean Imports
* Refine Formal Members
* Code folding
* Structured compare
* Mark occurrences

Check out the [screenshots](screenshots)!

## Running the pre-release IDE

If you *really* want to try out Ceylon now, you can [install a special 
pre-release build of the Ceylon IDE](install) (which includes the 
compiler) from our Eclipse plugin update site.
