require "bundler/gem_tasks"
require 'rspec/core/rake_task'

Dir["tasks/**/*.rake"].each do |file|
  load(file)
end

# Setup new RSpec for rake task
RSpec::Core::RakeTask.new(:spec)

# make default task to run specs
task :default => :spec
