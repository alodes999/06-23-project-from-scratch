require 'pry'
require 'sinatra'
require 'sinatra/reloader'

require 'sqlite3'
require_relative 'database_setup'

require_relative 'models/genres.rb'
require_relative 'models/games.rb'
require_relative 'models/users.rb'
# require_relative 'models/reviews.rb'
require_relative 'models/mediums.rb'

require_relative 'controllers/home.rb'
require_relative 'controllers/genre_control.rb'
require_relative 'controllers/game_control.rb'
require_relative 'controllers/user_control.rb'
# require_relative 'controllers/review_control.rb'
require_relative 'controllers/medium_control.rb'