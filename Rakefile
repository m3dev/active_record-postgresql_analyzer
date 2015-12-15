require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)
task default: :spec

namespace :spec do
  Dir::glob('gemfiles/*.gemfile').each do |gemfile|
    task_name = File.basename gemfile
    desc "Run Tests by #{gemfile}"
    task task_name do
      Bundler.with_clean_env do
        sh "BUNDLE_GEMFILE='#{gemfile}' bundle install --path vendor/bundle"
        sh "BUNDLE_GEMFILE='#{gemfile}' bundle exec rspec"
      end
    end
  end

  desc "Run All Tests"
  task :all do
    Dir::glob('gemfiles/*.gemfile').each do |gemfile|
      Rake::Task["spec:#{File.basename(gemfile)}"].invoke
    end
  end
end
