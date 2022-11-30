require_relative 'config/application'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require 'cucumber'
require 'cucumber/rake/task'

desc 'Generate a cryptographically secure secret key (this is typically used to generate a secret for cookie sessions).'
task :secret do
  require 'securerandom'
  puts SecureRandom.hex(64)
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "--format pretty"
end
