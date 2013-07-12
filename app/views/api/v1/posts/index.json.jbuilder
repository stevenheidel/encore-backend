json.posts do
  json.array! @posts do |post|
    json.id post.id.to_s
    json.extract! post, :caption, :image_url, :user_name, :user_profile_picture
  end
end