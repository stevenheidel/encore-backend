json.posts do
  json.array! @posts do |post|
    json.id post.id.to_s
    json.extract! post, :caption, :image_url, :user_name, :user_profile_picture

    if post.type == :youtube_video
      json.type "video"
      json.youtube_link post.link
    else
      json.type "photo"
    end
  end
end