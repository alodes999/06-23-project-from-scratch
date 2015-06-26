# This listener pulls from the main page, and sends the user to the genre_main page.
get '/genre' do
  erb :'genre/genre_main'
end
# This listener pulls from the genre main page, and sends the user to the genre_add page.
# This page allows the user to add a new unique genre name
get '/genre_add' do
  erb :'genre/genre_add'
end
# This listener pulls from the genre main page, and sends the user to the genre_change page.
# This page allows the user to change the name of a genre unattached to a game.
get '/genre_change' do
  erb :'genre/genre_change'
end
# This listener pulls from the genre main page, and sends the user to the genre_read page.
# This page lists all of the genre's in the DB
get '/genre_read' do
  erb :'genre/genre_read'
end
# This listener pulls from the genre main page, and sends the user to the genre_delete page.
# This page allows the user to delete a genre unattached to a game
get '/genre_delete' do
  erb :'genre/genre_delete'
end
# This listener pulls from the genre main page, and sends the user to the genre_games page.
# This page will request a certain genre, and will direct the user to a page showing a list
# of all the games in that genre
get '/genre_games' do
  erb :'genre/genre_games'
end
# This listener pulls from the genre_games.erb page.  It grabs the genre[list_id] from
# the input form and grabs the row from the genres table, storing that 
# object as @genre.  It also goes to the games table and pulls back a list of all games 
# that have that genres_id, storing that Array as @game_list.  The route handler sends
# those to genre_games_of to display the list of the appropriate Games of that Genre  
get "/genre_list_of_games" do
  @genre = Genre.find(params["genre"]["list_id"])
  @game_list = Game.games_in_genre(params["genre"]["list_id"])
  erb :"genre/genre_games_of"
end
# This listener pulls from the genre_add.erb page.  It grabs the genre[name] from
# the input form there and then checks to see if the name is already in the DB
# 
# If it is a new genre, it adds it and sends the user to the Success page listed
# 
# If it is a genre already there, or a blank field is submitted, 
# it sends the user to the Error page listed.
get '/genre_add_to_database' do
  add_hash = {"name" => params["genre"]["name"]}
  test = Genre.all
  test_names = []
  
  test.each do |item|
    test_names << item.name
  end
  
  if params["genre"]["name"] == "" 
    erb :"error/no_data_in_field"
  elsif test == []
    Genre.add(add_hash)
    erb :"success/data_added"
  elsif !test_names.include?(params["genre"]["name"])
    Genre.add(add_hash)
    erb :"success/data_added"
  else
    erb :"error/data_exists"
  end
end
# This listener pulls from the genre_change.erb page.  It grabs the param genre[change_id],
# an ID of the genre row we want to work with, and brings back an Object synched with the
# corresponding row in the DB.
# 
# It then changes the name attribute for that Object, using the 
# genre[new_name] param and saves the change back to the DB.
# 
# If games are attached, it sends the user to the Error page.
get '/genre_change_in_database' do
  if Game.games_in_genre(params["genre"]["change_id"].to_i) == []
    change_genre = Genre.find(params["genre"]["change_id"])
    change_genre.name = params["genre"]["new_name"]
    
    change_genre.save
    erb :"success/data_changed"
  else
    erb :"error/data_associated"
  end
end
# This listener pulls from the genre_delete.erb page.  It grabs the param genre[delete_id], an ID
# of the row we want to delete in the genres table.  It then deletes the row.
# 
# If games are attached, it sends the user to the Error page.
get '/genre_delete_from_database' do
  if Game.games_in_genre(params["genre"]["delete_id"].to_i) == []
    Genre.delete(params["genre"]["delete_id"])
    erb :"success/data_deleted"
  else
    erb :"error/data_associated"
  end
end