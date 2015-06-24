
get '/genre' do
  erb :'genre/genre_main'
end

get '/genre_add' do
  erb :'genre/genre_add'
end

get '/genre_change' do
  erb :'genre/genre_change'
end

get '/genre_read' do
  erb :'genre/genre_read'
end

get '/genre_delete' do
  erb :'genre/genre_delete'
end

get '/genre_games' do
  erb :'genre/genre_games'
end

get '/genre_add_to_database' do
  add_hash = {"name" => params["genre_name"]}
  test = Genre.all
  test_names = []
  
  test.each do |item|
    test_names << item.name
  end
  
  if test == []
    Genre.add(add_hash)
    erb :"success/data_added"
  elsif !test_names.include?(params["genre_name"])
    Genre.add(add_hash)
    erb :"success/data_added"
  else
    erb :"error/data_exists"
  end
end

get '/genre_change_in_database' do
#  if Genre.games_in_genre(params["genre_to_change"]) == []
    change_genre = Genre.find(params["genre_to_change"])
    change_genre.name = params["new_genre_name"]
    
    change_genre.save
    erb :"success/data_changed"
#  else
#    erb :"error/data_exists"
#  end
end

get '/genre_delete_from_database' do
#  if Genre.games_in_genre(params["genre_to_delete"]) == []
    Genre.delete(params["genre_to_delete"])
    erb :"success/data_deleted"
#  else
#    erb :"error/data_exists"
#  end
end