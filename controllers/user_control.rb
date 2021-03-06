# This listener pulls from the main page, and sends the user to the user_main page.
get "/user" do
  erb :"/user/user_main"
end
# This listener pulls from the user main page, and sends the user to the user_read page.
# This page lists all of the user's in the DB
get "/users_read" do
  @user = User.all
  erb :'/user/user_read'
end
# This listener pulls from the user main page, and sends the user to the user_add page.
# This page allows the user to add a new unique user name
get "/users_add" do
  erb :'/user/user_add'
end
# This listener pulls from the user main page, and sends the user to the user_change page.
# This page allows the user to change the name of a user unattached to a review.
get "/users_change" do
  @user = User.all
  erb :'/user/user_change'
end
# This listener pulls from the user main page, and sends the user to the user_delete page.
# This page allows the user to delete a user unattached to a review
get "/users_delete" do
  @user = User.all
  erb :'/user/user_delete'
end
# This listener pulls from the user main page, and sends the user to the user_games page.
# This page will request a certain user, and will direct the user to a page showing a list
# of all the reviews for that user
get '/users_reviews' do
  @user = User.all
  erb :'/user/user_reviews'
end
# This listener pulls from the user_reviews.erb page.  It grabs the user[list_id] from
# the input form and grabs the row from the users table, storing that 
# object as @user.  It also goes to the reviews table and pulls back a list of all reviews 
# that have that users_id, storing that Array as @review_list.  The route handler sends
# those to user_reviews_list to display the list of the appropriate Reviews of that User  
get "/users_list_of_reviews" do
  @game = Game.all
  @user = User.find(params["user"]["list_id"])
  @review_list = Review.reviews_for_user(params["user"]["list_id"])
  erb :"user/user_reviews_list"
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
  
  if params["user"]["name"] == ""
    erb :"error/no_data_in_field"
  elsif User.add_with_name_val(add_hash)
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
# If reviews are attached, it sends the user to the Error page.
get "/user_change_in_database" do
  if Review.reviews_for_user(params["user"]["change_id"]) == []
    change_user = User.find(params["user"]["change_id"])
    change_user.name = params["user"]["new_name"]
  
    change_user.save
    erb :"success/data_changed"
  else
    erb :"error/data_associated"
  end
end
# This listener pulls from the user_delete.erb page.  It grabs the param user[delete_id], an ID
# of the row we want to delete in the users table.  It then deletes the row.
# 
# If reviews are attached, it sends the user to the Error page.
get "/user_delete_from_database" do
  if Review.reviews_for_user(params["user"]["delete_id"]) == []
    User.delete(params["user"]["delete_id"])
    erb :"success/data_deleted"
  else
    erb :"error/data_associated"
  end
end