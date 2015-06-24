require_relative '../database_class_methods.rb'
require_relative '../database_instance_methods.rb'


class Genre
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_accessor :id, :name

  def initialize(options={})
    @id = options["id"]
    @name = options["name"]
  end

  def self.games_in_genre(id)
    gameslist = CONNECTION.execute("SELECT * FROM games WHERE genre_id = #{id};")
    genre_array = []
    gameslist.each do |game|
      genre_array << Game.new(game)
    end

    genre_array
  end

end