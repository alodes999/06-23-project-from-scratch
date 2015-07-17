require 'rubygems'
require 'bundler/setup'

require 'pry'
require 'sinatra'
require 'sinatra/reloader'

require 'sqlite3'
require_relative 'database_setup'

configure :development do
  ActiveRecord:Base.establish_connection(adapter: 'sqlite3', database: 'gamereviewrepos.db')
end

require_relative 'models/genres.rb'
require_relative 'models/games.rb'
require_relative 'models/users.rb'
require_relative 'models/reviews.rb'
require_relative 'models/formats.rb'

require_relative 'controllers/home.rb'
require_relative 'controllers/genre_control.rb'
require_relative 'controllers/game_control.rb'
require_relative 'controllers/user_control.rb'
require_relative 'controllers/review_control.rb'
require_relative 'controllers/format_control.rb'