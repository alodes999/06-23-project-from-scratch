require_relative '../database_class_methods.rb'
require_relative '../database_instance_methods.rb'


class Game
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_reader :id
  attr_accessor :name, :genres_id, :formats_id
  # This is our initialize method for my Game class(model).  We have four attributes, the id, an Integer
  # corresponding to the row in our DB table, name, the name of our game, as a String, genres_id, an Integer
  # corresponding to the id of the associated genre from the genres table, and formats_id, an Integer
  # corresponding to the id of the associated format from the formats table
  # 
  # We have 1 optional argument, a Hash, that can contain an id or name.
  def initialize(options={})
    @id = options["id"]
    @name = options["name"]
    @genres_id = options["genres_id"]
    @formats_id = options["formats_id"]
  end
  # This class method allows us to list all of the games associated with the given Format.
  # 
  # This accepts one argument, the id of the format we want to look up
  # 
  # Returns an Array of Game class Objects that belong to the format looked up
  def self.games_in_format(id)
    gameslist = CONNECTION.execute("SELECT * FROM games WHERE formats_id = #{id};")
    format_array = []
    gameslist.each do |game|
      format_array << Game.new(game)
    end

    format_array
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