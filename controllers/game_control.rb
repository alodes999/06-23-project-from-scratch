# This listener pulls from the main page, and sends the user to the game_main page.
get "/game" do
  erb :"/game/game_main"
end
# This listener pulls from the game main page, and sends the user to the game_read page.
# This page lists all of the game's in the DB
get "/games_read" do
  @game = Game.all
  @genre = Genre.all
  @format = Format.all
  erb :'game/game_read'
end
# This listener pulls from the game main page, and sends the user to the game_add page.
# This page allows the user to add a new unique game name
get "/games_add" do
  @genre = Genre.all
  @format = Format.all
  erb :'game/game_add'
end
# This listener pulls from the game main page, and sends the user to the game_change page.
# This page allows the user to change the name of a game unattached to a game.
get "/games_change" do
  @game = Game.all
  erb :'game/game_change'
end
# This listener pulls from the game main page, and sends the user to the game_delete page.
# This page allows the user to delete a game unattached to a game
get "/games_delete" do
  @game = Game.all
  erb :'game/game_delete'
end
# This listener pulls from the game main page, and sends the user to the game_reviews page.
# This page will request a certain game, and will direct the user to a page showing a list
# of all the reviews in that game
get "/games_reviews" do
  @game = Game.all
  erb :'game/game_reviews'
end
# This listener pulls from the game_reviews.erb page.  It grabs the game[list_id] from
# the input form and grabs the row from the games table, storing that 
# object as @game.  It also goes to the reviews table and pulls back a list of all reviews 
# that have that games_id, storing that Array as @review_list.  The route handler sends
# those to game_reviews_list to display the list of the appropriate Reviews of that Game  
get "/games_list_of_reviews" do
  @users = User.all
  @game = Game.find(params["game"]["list_id"])
  @review_list = Review.reviews_for_game(params["game"]["list_id"])
  erb :"game/game_reviews_list"
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
  @genre = Genre.all
  @format = Format.all
  @change_game_pick = Game.find(params["game"]["id"])
  if Review.reviews_for_game(params["game"]["id"]) == []
    erb :"game/game_change_action"
  else
    erb :"error/data_associated"
  end
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
  if Review.reviews_for_game(params["game"]["delete_id"]) == []
    Game.delete(params["game"]["delete_id"])
    erb :"success/data_deleted"
  else
    erb :"error/data_associated"
  end
end