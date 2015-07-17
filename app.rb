require 'rubygems'
require 'bundler/setup'

require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require "active_record"

require ''
require_relative 'database_setup'

configure :development do
  require 'sqlite3'
  ActiveRecord:Base.establish_connection(adapter: 'sqlite3', database: 'gamereviewrepos.db')
end

configure :production do  
  require 'pg'
  db = URI.parse(ENV['DATABASE_URL'])

  ActiveRecord::Base.establish_connection(
    :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
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