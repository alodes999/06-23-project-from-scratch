get "/game" do
  erb :"/game/game_main"
end

get "/games_read" do
  erb :'game/game_read'
end

get "/games_add" do
  erb :'game/game_add'
end

get "/games_change" do
  erb :'game/game_change'
end

get "/games_delete" do
  erb :'game/game_delete'
end

get "/games_reviews" do
  erb :'game/game_reviews'
end
# This listener pulls from the game_add.erb page.  It grabs the game[name] from
# the input form there and then checks to see if the name is already in the DB
# 
# If it is a new game, it adds it and sends the user to the Success page listed
# 
# If it is a game already there, or a blank field is submitted, 
# it sends the user to the Error page listed.
get '/game_add_to_database' do
  add_hash = {"name" => params["game"]["name"], "genres_id" => params["game"]["genres_id"].to_i, "formats_id" => params["game"]["formats_id"].to_i}
  test = Game.all
  test_names = []
  
  test.each do |item|
    test_names << item.name
  end
  
  if params["game"]["name"].empty? 
    erb :"error/no_data_in_field"
  elsif test == []
    Game.add(add_hash)
    erb :"success/data_added"
  elsif !test_names.include?(params["game"]["name"])
    Game.add(add_hash)
    erb :"success/data_added"
  else
    erb :"error/data_exists"
  end
end
# This listener pulls from the game_change.erb page.  It grabs the id of the Game
# row we want to change from params["game"]["id"] and creates a Game Object.
# If there are no reviews tied to the game, it then sends that game object to 
# the game_change_action.erb page, where the changes are made. If there are
# reviews tied to the game, it sends the user to the data_exists error page.
get "/game_change_input" do
  @change_game_pick = Game.find(params["game"]["id"])
  if Game.reviews_for_game(params["game"]["id"]) == []
    erb :"game/game_change_action"
  else
    erb :"error/data_exists"
end
# This listener pulls from the game_change_action.erb page.  It pushes the params["game"]
# hash the form returns into a variable, checks to see if the name was empty, and passes the
# changed values into an instantiated Game Object to update the values.  The updated Object
# has its' .save method called to send the values back to the Database row it belongs to.
get "/game_change_in_database" do
  change_hash = params["game"]
  if change_hash["name"].empty?
    erb :"error/no_data_in_field"
  else
    game_to_change = Game.find(params["game"]["id"])
  
    game_to_change.name = change_hash["name"]
    game_to_change.genres_id = change_hash["genres_id"]
    game_to_change.formats_id = change_hash["formats_id"]
  
    game_to_change.save
  
    erb :"success/data_changed"
  end
end
# This listener pulls from the game_delete.erb page.  It grabs the param game[delete_id], an ID
# of the row we want to delete in the games table.  It then deletes the row, and sends the 
# user to the success page.
# 
# If reviews are attached, it sends the user to the Error page.
get '/game_delete_from_database' do
  if Game.reviews_for_game(params["game"]["delete_id"]) == []
    Game.delete(params["game"]["delete_id"])
    erb :"success/data_deleted"
  else
    erb :"error/data_exists"
  end
end