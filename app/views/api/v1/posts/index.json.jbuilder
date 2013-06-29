json.posts do
  json.array! @posts, :id, :caption, :link, :image_url, 
    :user_name, :user_profile_picture, :user_uuid
end