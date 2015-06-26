require_relative '../database_class_methods.rb'
require_relative '../database_instance_methods.rb'


class Genre
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_accessor :id, :name
  # This is our initialize method for my Genre class(model).  We have two attributes, the id, an Integer
  # corresponding to the row in our DB table, and name, the name of our genre, as a String
  # 
  # We have 1 optional argument, a Hash, that can contain an id or name.
  def initialize(options={})
    @id = options["id"]
    @name = options["name"]
  end
  # This class method allows us to list all of the games associated with the given Genre.
  # 
  # This accepts one argument, the id of the genre we want to look up
  # 
  # Returns an Array of Game class Objects that belong to the genre looked up
  def self.games_in_genre(id)
    gameslist = CONNECTION.execute("SELECT * FROM games WHERE genres_id = #{id};")
    genre_array = []
    gameslist.each do |game|
      genre_array << Game.new(game)
    end

    genre_array
  end

end