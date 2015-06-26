get "/review" do
  erb :"/review/review_main"
end
# This listener pulls from the review main page, and sends the user to the review_read page.
# This page lists all of the review's in the DB
get "/review_read" do
  erb :'/review/review_read'
end
# This listener pulls from the review main page, and sends the user to the review_add page.
# This page allows the user to add a new review
get "/review_add" do
  erb :'/review/review_add'
end
# This listener pulls from the review main page, and sends the review to the review_change page.
# This page allows the user to pick which review to modify.  Once there, the user can pick to
# change the game or user the review attached to, or the reviews score.  Once submitted,
# it is sent to the reviews_change_to_database route.
get "/review_change" do
  erb :'/review/review_change'
end
# This listener pulls from the review main page, and sends the user to the review_delete page.
# This page allows the user to delete a review.
get "/review_delete" do
  erb :'/review/review_delete'
end
# This listener pulls from the review_add.erb page.  It grabs the params from
# the form and adds it to the add_hash, sending it to
# a new Object and into the reviews table, and sends the user to the Success page listed
# 
# If a blank field is submitted, it sends the review to the Error page listed.
get "/review_add_to_database" do
  add_hash = {"users_id" => params["review"]["users_id"], "games_id" => params["review"]["games_id"], "score" => params["review"]["score"]}
  
  if params["review"]["score"] == "" 
    erb :"error/no_data_in_field"
  else
    Review.add(add_hash)
    erb :"success/data_added"
  end
end
# This listener pulls from the review_change.erb page.  It grabs the param review[change_id],
# an ID of the review row we want to work with, and brings back an Object synched with the
# corresponding row in the DB.
# 
# It then changes the name attribute for that Object, using the 
# review[new_name] param and saves the change back to the DB.
get "/review_change_in_database" do
  change_review = Review.find(params["review"]["change_id"])
  
  change_review.users_id = params["review"]["users_id"]
  change_review.games_id = params["review"]["games_id"]
  change_review.score = params["review"]["score"]
  
  change_review.save
  erb :"success/data_changed"
end
# This listener pulls from the review_delete.erb page.  It grabs the param review[delete_id], an ID
# of the row we want to delete in the reviews table.  It then deletes the row.
get "/review_delete_from_database" do
  Review.delete(params["review"]["delete_id"])
  erb :"success/data_deleted"
end