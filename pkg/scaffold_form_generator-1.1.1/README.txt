=ScaffoldForm Generator
    by Brian Hogan
    http://www.napcs.com

== DESCRIPTION:
  
Scaffolding, out of the box, is really not a good idea. You'll generate a bunch of stuff you might not use, and some of it isn't really production-worthy. However, when you stop using it, you notice that there's one part that saves you some serious time, and that's the form creation. This plugin takes code from Rails' legacy scaffold generator and makes it available again, but this time it only builds the new and edit forms.

== FEATURES/PROBLEMS:
  
* Using form_for with the RESTful syntax with form_for and friends
* LOCK_VERSION, CREATED_AT, CREATED_ON, UPDATED_AT, UPDATED_ON fields, and anything with an _id at the end are skipped
* Boolean fields are done as checkboxes instead of selects.

== SYNOPSIS:

  ruby script/generate Project projects

== REQUIREMENTS:

* Rails, a model, and a table in your database that is already migrated.

== INSTALL:

* Mac and Linux: sudo gem install scaffold_form_generator
* Windows: gem install scaffold_form_generator

== LICENSE:

(The MIT License)

Copyright (c) 2007 Brian Hogan with code from http://dev.rubyonrails.org/

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
