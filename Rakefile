require 'rake/testtask'

task default: %w[run]

task :run do
  ruby 'bin/presidential_survival.rb'
end

Rake::TestTask.new do |t|
  t.pattern = "test/*_test.rb"
end
