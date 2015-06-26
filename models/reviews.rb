require_relative '../database_class_methods.rb'
require_relative '../database_instance_methods.rb'


class Review
  extend DatabaseClassMethods
  include DatabaseInstanceMethods
  
  attr_reader :id
  attr_accessor :score, :games_id, :users_id
  # This is our initialize method for my Review class(model).  We have four attributes, the id, an Integer
  # corresponding to the row in our DB table, games_id, an Integer that corresponds with the associated row
  # in the games table, users_id, an Integer that corresponds with the associated row in the users table, and
  # review_score, an Integer, which is the user input for the score a certain game review gets.
  # 
  # We have 1 optional argument, a Hash, that can contain an id or name.
  def initialize(options={})
    @id = options["id"]
    @games_id = options["games_id"]
    @users_id = options["users_id"]
    @score = options["score"]
  end
end