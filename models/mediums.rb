require_relative '../database_class_methods.rb'
require_relative '../database_instance_methods.rb'


class Medium
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_accessor :id, :name
  # This is our initialize method for my Medium class(model).  We have two attributes, the id, an Integer
  # corresponding to the row in our DB table, and name, the name of our medium, as a String
  # 
  # We have 1 optional argument, a Hash, that can contain an id or name.
  def initialize(options={})
    @id = options["id"]
    @name = options["name"]
  end
  # This class method allows us to list all of the games associated with the given Medium.
  # 
  # This accepts one argument, the id of the medium we want to look up
  # 
  # Returns an Array of Game class Objects that belong to the medium looked up
  def self.games_in_medium(id)
    gameslist = CONNECTION.execute("SELECT * FROM games WHERE mediums_id = #{id};")
    medium_array = []
    gameslist.each do |game|
      medium_array << Game.new(game)
    end

    medium_array
  end

end