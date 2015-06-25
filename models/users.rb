require_relative '../database_class_methods.rb'
require_relative '../database_instance_methods.rb'


class User
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_accessor :id, :name
  # This is our initialize method for my User class(model).  We have two attributes, the id, an Integer
  # corresponding to the row in our DB table, and name, the name of our user, as a String
  # 
  # We have 1 optional argument, a Hash, that can contain an id or name.
  def initialize(options={})
    @id = options["id"]
    @name = options["name"]
  end
end