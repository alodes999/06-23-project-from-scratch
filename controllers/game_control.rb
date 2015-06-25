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
  erb :'game/games_reviews'
end