get "/format" do
  erb :"/format/format_main"
end
# This listener pulls from the format main page, and sends the user to the format_read page.
# This page lists all of the format's in the DB
get "/format_read" do
  @format = Format.all
  erb :'format/format_read'
end
# This listener pulls from the format main page, and sends the user to the format_add page.
# This page allows the user to add a new unique format name
get "/format_add" do
  erb :'format/format_add'
end
# This listener pulls from the format main page, and sends the user to the format_change page.
# This page allows the user to change the name of a format unattached to a game.
get "/format_change" do
  @format = Format.all
  erb :'format/format_change'
end
# This listener pulls from the format main page, and sends the user to the format_delete page.
# This page allows the user to delete a format unattached to a game
get "/format_delete" do
  @format = Format.all
  erb :'format/format_delete'
end
# This listener pulls from the format main page, and sends the user to the format_games page.
# This page will request a certain format, and will direct the user to a page showing a list
# of all the games in that format
get "/format_games" do
  @format = Format.all
  erb :'format/format_games'
end
# This listener pulls from the format_games.erb page.  It grabs the format[list_id] from
# the input form and grabs the row from the formats table, storing that 
# object as @format.  It also goes to the games table and pulls back a list of all games 
# that have that formats_id, storing that Array as @game_list.  The route handler sends
# those to format_games_of to display the list of the appropriate Games of that Format  
get "/format_list_of_games" do
  @format = Format.find(params["format"]["list_id"])
  @game_list = Game.games_in_format(params["format"]["list_id"])
  erb :"format/format_games_of"
end
# This listener pulls from the format_add.erb page.  It grabs the format[name] from
# the input form there and then checks to see if the name is already in the DB
# 
# If it is a new format, it adds it and sends the user to the Success page listed
# 
# If it is a format already there, or a blank field is submitted, 
# it sends the user to the Error page listed.
get '/format_add_to_database' do
  add_hash = {"name" => params["format"]["name"]}
  
  if params["format"]["name"] == ""
    erb :"error/no_data_in_field"
  elsif Format.add_with_name_val(add_hash)
    erb :"success/data_added"
  else
    erb :"error/data_exists"
  end
end
# This listener pulls from the format_change.erb page.  It grabs the param format[change_id],
# an ID of the format row we want to work with, and brings back an Object synched with the
# corresponding row in the DB.
# 
# It then changes the name attribute for that Object, using the 
# format[new_name] param and saves the change back to the DB.
# 
# Once we add the games table, it will check to see if the format has games attached.  If it
# does not, the change goes through and the user is sent to the Success page.
# 
# If games are attached, it sends the user to the Error page.
get '/format_change_in_database' do
  if Game.games_in_format(params["format"]["change_id"]) == []
    change_format = Format.find(params["format"]["change_id"])
    change_format.name = params["format"]["new_name"]
    
    change_format.save
    erb :"success/data_changed"
  else
    erb :"error/data_associated"
  end
end
# This listener pulls from the format_delete.erb page.  It grabs the param format[delete_id], an ID
# of the row we want to delete in the formats table.  It then deletes the row.
# 
# Once we add the games table, it will check to see if the format has games attached.  If it
# does not, the delete goes through and the user is sent to the Success page.
# 
# If games are attached, it sends the user to the Error page.
get '/format_delete_from_database' do
  if Game.games_in_format(params["format"]["delete_id"]) == []
    Format.delete(params["format"]["delete_id"])
    erb :"success/data_deleted"
  else
    erb :"error/data_associated"
  end
end