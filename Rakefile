# -*- ruby -*-

class Hoe
  
  # remove dependency on Hoe
  def extra_deps
      @extra_deps.reject{|x| Array(x).first == 'hoe'}
  end
end



require 'rubygems'
require 'hoe'


Hoe.new('scaffold_form_generator', '1.1.1') do |p|
  p.rubyforge_name = 'scaffoldform'
  p.name = "scaffold_form_generator"
  p.author = 'Brian Hogan'
  p.email = 'info@napcs.com'
  p.summary = 'Form generation for Rails models based on original scaffolding'
  p.description = 'Form generation for Rails models based on original scaffolding with some minor tweaks.'
  # p.url = p.paragraphs_of('README.txt', 0).first.split(/\n/)[1..-1]
  p.changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
  #p.need_tar = false
  #p.need_zip = false
  p.remote_rdoc_dir = ''
end

# vim: syntax=Ruby
