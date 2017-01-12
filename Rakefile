#!/usr/bin/env rake

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = "--format=#{ENV['FORMATTER']}" if ENV['FORMATTER']
  t.rspec_opts = '--color'
  t.verbose = false
end

task :default => :spec
