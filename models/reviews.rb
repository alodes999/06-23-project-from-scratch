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
  # This class method allows us to list all of the reviews associated with the given Game.
  # 
  # This accepts one argument, the id of the Game we want to look up
  # 
  # Returns an Array of Review class Objects that belong to the Game looked up
  def self.reviews_for_game(id)
    reviewslist = CONNECTION.execute("SELECT * FROM reviews WHERE games_id = #{id};")
    game_array = []
    reviewslist.each do |review|
      game_array << Review.new(review)
    end

    game_array
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