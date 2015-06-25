require_relative '../database_class_methods.rb'
require_relative '../database_instance_methods.rb'


class Game
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_accessor :id, :name, :genres_id, :formats_id
  # This is our initialize method for my Game class(model).  We have two attributes, the id, an Integer
  # corresponding to the row in our DB table, and name, the name of our game, as a String
  # 
  # We have 1 optional argument, a Hash, that can contain an id or name.
  def initialize(options={})
    @id = options["id"]
    @name = options["name"]
    @genres_id = options["genres_id"]
    @formats_id = options["formats_id"]
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
end