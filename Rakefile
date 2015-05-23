require "bundler/gem_tasks"
require 'rspec/core/rake_task'

desc "Run specs"
RSpec::Core::RakeTask.new :spec

task :default => :spec

desc "start a console in the context of hombot"
task :console do
  require 'hombot'

  require 'irb'
  require 'irb/completion'
  ARGV.clear
  IRB.start
end