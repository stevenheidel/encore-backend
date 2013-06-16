json.posts do
  json.array! @posts, :instagram_uuid, :caption, :link, :image_url, 
    :user_name, :user_profile_picture, :user_uuid
end