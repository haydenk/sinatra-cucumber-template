require 'sinatra/activerecord'
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
