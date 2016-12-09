require File.expand_path("../engine", File.dirname(__FILE__))
namespace :test do
  desc "Run the plugin unit test suite."
  task :ovm => ['db:test:prepare'] do
    test_task = Rake::TestTask.new('ovm_test_task') do |t|
      t.libs << ["test", "#{ForemanOvm::Engine.root}/test"]
      t.test_files = [
        "#{ForemanOvm::Engine.root}/test/**/*_test.rb"
      ]
      t.verbose = true
      t.warning = false
    end

    Rake::Task[test_task.name].invoke
  end
end

namespace :ovm do
  task :rubocop do
    begin
      require 'rubocop/rake_task'
      RuboCop::RakeTask.new(:rubocop_ovm) do |task|
        task.patterns = ["#{ForemanOvm::Engine.root}/app/**/*.rb",
                         "#{ForemanOvm::Engine.root}/lib/**/*.rb",
                         "#{ForemanOvm::Engine.root}/test/**/*.rb"]
      end
    rescue
      puts "Rubocop not loaded."
    end

    Rake::Task['rubocop_ovm'].invoke
  end
end

Rake::Task[:test].enhance do
  Rake::Task['test:ovm'].invoke
end

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:unit')
  Rake::Task["jenkins:unit"].enhance do
    Rake::Task['test:ovm'].invoke
    Rake::Task['ovm:rubocop'].invoke
  end
end
