require_relative 'config/application'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'

desc 'Generate a cryptographically secure secret key (this is typically used to generate a secret for cookie sessions).'
task :secret do
  require 'securerandom'
  puts SecureRandom.hex(64)
end