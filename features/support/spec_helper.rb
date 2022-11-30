module RSpecMixin
  include Rack::Test::Methods
  def app()
    Template::App
  end
end

RSpec.configure do |config|
  config.include RSpecMixin
end