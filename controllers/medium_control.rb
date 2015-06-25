get "/medium" do
  erb :"/medium/medium_main"
end
# This listener pulls from the medium main page, and sends the user to the medium_read page.
# This page lists all of the medium's in the DB
get "/medium_read" do
  erb :'medium/medium_read'
end
# This listener pulls from the medium main page, and sends the user to the medium_add page.
# This page allows the user to add a new unique medium name
get "/medium_add" do
  erb :'medium/medium_add'
end
# This listener pulls from the medium main page, and sends the user to the medium_change page.
# This page allows the user to change the name of a medium unattached to a game.
get "/medium_change" do
  erb :'medium/medium_change'
end
# This listener pulls from the medium main page, and sends the user to the medium_delete page.
# This page allows the user to delete a medium unattached to a game
get "/medium_delete" do
  erb :'medium/medium_delete'
end
# This listener pulls from the medium main page, and sends the user to the medium_games page.
# This page will request a certain medium, and will direct the user to a page showing a list
# of all the games in that medium
get "/medium_games" do
  erb :'medium/medium_games'
end
# This listener pulls from the medium_add.erb page.  It grabs the medium[name] from
# the input form there and then checks to see if the name is already in the DB
# 
# If it is a new medium, it adds it and sends the user to the Success page listed
# 
# If it is a medium already there, or a blank field is submitted, 
# it sends the user to the Error page listed.
get '/medium_add_to_database' do
  add_hash = {"name" => params["medium"]["name"]}
  test = Medium.all
  test_names = []
  
  test.each do |item|
    test_names << item.name
  end
  
  if params["medium"]["name"] == "" 
    erb :"error/no_data_in_field"
  elsif test == []
    Medium.add(add_hash)
    erb :"success/data_added"
  elsif !test_names.include?(params["medium"]["name"])
    Medium.add(add_hash)
    erb :"success/data_added"
  else
    erb :"error/data_exists"
  end
end
# This listener pulls from the medium_change.erb page.  It grabs the param medium[change_id],
# an ID of the medium row we want to work with, and brings back an Object synched with the
# corresponding row in the DB.
# 
# It then changes the name attribute for that Object, using the 
# medium[new_name] param and saves the change back to the DB.
# 
# Once we add the games table, it will check to see if the medium has games attached.  If it
# does not, the change goes through and the user is sent to the Success page.
# 
# If games are attached, it sends the user to the Error page.
get '/medium_change_in_database' do
#  if Medium.games_in_medium(params["medium_to_change"]) == []
    change_medium = Medium.find(params["medium"]["change_id"])
    change_medium.name = params["medium"]["new_name"]
    
    change_medium.save
    erb :"success/data_changed"
#  else
#    erb :"error/data_exists"
#  end
end
# This listener pulls from the medium_delete.erb page.  It grabs the param medium[delete_id], an ID
# of the row we want to delete in the mediums table.  It then deletes the row.
# 
# Once we add the games table, it will check to see if the medium has games attached.  If it
# does not, the delete goes through and the user is sent to the Success page.
# 
# If games are attached, it sends the user to the Error page.
get '/medium_delete_from_database' do
#  if Medium.games_in_medium(params["medium_to_delete"]) == []
    Medium.delete(params["medium"]["delete_id"])
    erb :"success/data_deleted"
#  else
#    erb :"error/data_exists"
#  end
end