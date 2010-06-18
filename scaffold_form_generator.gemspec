# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{scaffold_form_generator}
  s.version = "1.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brian Hogan"]
  s.date = %q{2010-06-17}
  s.description = %q{Form generation for Rails models based on original scaffolding with some minor tweaks. Need to whip up a form quickly? Use this. Or use Formtastic which works better because it has better form helpers than Rails does.
    
    Scaffolding, out of the box, is really not a good idea. You'll generate a bunch of stuff you might not use, and some of it isn't really production-worthy. However, when you stop using it, you notice that there's one part that saves you some serious time, and that's the form creation. This plugin takes code from Rails' legacy scaffold generator and makes it available again, but this time it only builds the new and edit forms.}
  s.email = %q{info@napcs.com}
  s.extra_rdoc_files = ["README.rdoc", "History.txt"]
  s.files = ["README.rdoc", "History.txt", "lib/scaffold_form.rb", "scaffold_form_generator.rb", "templates/form.rhtml", "templates/form_scaffolding.rhtml", "templates/view_edit.rhtml", "templates/view_new.rhtml", "test/test_scaffold_form.rb"]

  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{scaffoldform}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Form generation for Rails models based on original scaffolding}
  s.test_files = ["test/test_scaffold_form.rb"]


end
