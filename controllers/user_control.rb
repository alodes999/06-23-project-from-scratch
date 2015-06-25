get "/user" do
  erb :"/user/user_main"
end

get "/users_read" do
  erb :'/user/user_read'
end

get "/users_add" do
  erb :'/user/user_add'
end

get "/users_change" do
  erb :'/user/user_change'
end

get "/users_delete" do
  erb :'/user/user_delete'
end

get '/users_reviews' do
  erb :'/user/user_reviews'
end
# This listener pulls from the user_add.erb page.  It grabs the user[name] from
# the input form there and then checks to see if the name is already in the DB
# 
# If it is a new user, it adds it and sends the user to the Success page listed
# 
# If it is a user already there, or a blank field is submitted, 
# it sends the user to the Error page listed.
get "/user_add_to_database" do
  add_hash = {"name" => params["user"]["name"]}
  test = User.all
  test_names = []
  
  test.each do |item|
    test_names << item.name
  end
  
  if params["user"]["name"] == "" 
    erb :"error/no_data_in_field"
  elsif test == []
    User.add(add_hash)
    erb :"success/data_added"
  elsif !test_names.include?(params["user"]["name"])
    User.add(add_hash)
    erb :"success/data_added"
  else
    erb :"error/data_exists"
  end
end
# This listener pulls from the user_change.erb page.  It grabs the param user[change_id],
# an ID of the user row we want to work with, and brings back an Object synched with the
# corresponding row in the DB.
# 
# It then changes the name attribute for that Object, using the 
# user[new_name] param and saves the change back to the DB.
# 
# Once we add the reviews table, it will check to see if the user has reviews attached.  If it
# does not, the change goes through and the user is sent to the Success page.
# 
# If reviews are attached, it sends the user to the Error page.
get "/user_change_in_database" do
  #  if User.reviews_for_user(params["user"]["change_id"]) == []
      change_user = User.find(params["user"]["change_id"])
      change_user.name = params["user"]["new_name"]
    
      change_user.save
      erb :"success/data_changed"
  #  else
  #    erb :"error/data_exists"
  #  end
end
# This listener pulls from the user_delete.erb page.  It grabs the param user[delete_id], an ID
# of the row we want to delete in the users table.  It then deletes the row.
# 
# Once we add the reviews table, it will check to see if the user has reviews attached.  If it
# does not, the delete goes through and the user is sent to the Success page.
# 
# If reviews are attached, it sends the user to the Error page.
get "/user_delete_from_database" do
  #  if User.reviews_for_user(params["user"]["delete_id"]) == []
      User.delete(params["user"]["delete_id"])
      erb :"success/data_deleted"
  #  else
  #    erb :"error/data_exists"
  #  end
end