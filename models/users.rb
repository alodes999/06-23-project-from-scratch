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
  # This class method allows us to list all of the reviews associated with the given User.
  # 
  # This accepts one argument, the id of the User we want to look up
  # 
  # Returns an Array of Review class Objects that belong to the User looked up
  def self.reviews_for_user(id)
    reviewslist = CONNECTION.execute("SELECT * FROM reviews WHERE users_id = #{id};")
    user_array = []
    reviewslist.each do |review|
      user_array << Review.new(review)
    end

    user_array
  end
end