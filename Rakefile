require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the rcumber_rails plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the rcumber_rails plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'RcumberRails'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
ENV['NODOT'] = 'true' # We don't want class diagrams in RDoc
require 'config/requirements'
require 'config/hoe' # setup Hoe + all gem configuration

Dir['gem_tasks/**/*.rake'].each { |rake| load rake }

# Hoe gives us :default => :test, but we don't have Test::Unit tests.
Rake::Task[:default].clear_prerequisites
task :default => [:spec, :features]
