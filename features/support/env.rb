ENV['RACK_ENV'] = 'test'

require 'capybara'
require 'capybara/cucumber'
require 'cucumber/rspec/doubles'
require 'rack/test'
require 'rspec/expectations'

class SinatraWorld
  require 'selenium-webdriver'
  require "#{File.dirname(__FILE__ )}/../../config/application"

  Capybara.default_driver = :selenium
  Capybara.register_server :puma do |app, port, host|
    require 'rack/handler/puma'
    Rack::Handler::Puma.run(app, Host: host, Port: port, Threads: "0:4")
  end

  Capybara.server = :puma

  # Uncomment if you wish to use Chrome instead of Firefox
  # Download the ChromeDriver from: https://code.google.com/p/selenium/wiki/ChromeDriver
  #
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end

  # use the rackup file to load the apps w/their respective URL mappings, sweet!
  Capybara.app = Template::App

  # Before do
  #   Fixtures.reset_cache
  #   fixtures_folder = File.join(RAILS_ROOT, 'spec', 'fixtures')
  #   fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
  #   Fixtures.create_fixtures(fixtures_folder, fixtures)
  # end

  include Capybara::DSL
  include RSpec::Expectations
end

World do
  SinatraWorld.new
end