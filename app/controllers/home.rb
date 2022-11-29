module Template
  class App < BaseApp
    get '/' do
      haml 'home/index'.to_sym
    end
  end
end
