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
# This listener pulls from the game_delete.erb page.  It grabs the param game[delete_id], an ID
# of the row we want to delete in the games table.  It then deletes the row.
# 
# Once we add the games table, it will check to see if the game has reviews attached.  If it
# does not, the delete goes through and the user is sent to the Success page.
# 
# If reviews are attached, it sends the user to the Error page.
get '/game_delete_from_database' do
#  if Game.reviews_for_game(params["game_to_delete"]) == []
    Game.delete(params["game"]["delete_id"])
    erb :"success/data_deleted"
#  else
#    erb :"error/data_exists"
#  end
end