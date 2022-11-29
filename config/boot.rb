require 'sinatra'

ENV['RACK_ENV'] ||= 'development'
ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require 'rubygems' unless defined?(Gem)
require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.
