json.posts do
  json.array! @posts, :id, :caption, :image_url, 
    :user_name, :user_profile_picture
end