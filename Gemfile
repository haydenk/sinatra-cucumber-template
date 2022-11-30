source 'https://rubygems.org'
ruby RUBY_VERSION

gem 'sinatra', '~> 2.2', :require => 'sinatra/base'
gem 'sinatra-contrib', '~> 2.2'
gem 'sinatra-flash', '~> 0.3.0', require: 'sinatra/flash'
gem 'warden', '~> 1.2', '>= 1.2.9'
gem 'haml', '~> 6.0', '>= 6.0.11'
gem "puma", "~> 5.0"
gem 'oj', '~> 3.13', '>= 3.13.14'
gem 'activerecord', '~> 7.0', '>= 7.0.3'
gem 'sinatra-activerecord', '~> 2.0', '>= 2.0.25'
gem 'bcrypt', '~> 3.1', '>= 3.1.18'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.15', require: false

group :development, :test do
  gem 'rake', '~> 13.0', '>= 13.0.6'
  gem 'sqlite3', '~> 1.4', '>= 1.4.3'
  gem 'foreman', '~> 0.87.2'
  gem 'cucumber', '~> 3.1'
  gem 'capybara', '~> 2.17'
  gem 'rspec', '~> 3.7'
  gem 'rack-test', '~> 0.8.2'
  gem 'selenium-webdriver', '~> 3.8'
end
