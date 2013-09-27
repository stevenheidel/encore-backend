json.array! @friends do |user|
  json.facebook_id        user.facebook_id
  json.name               user.name
  json.facebook_image_url user.facebook_image_url
  json.invite_sent        user.invited?
end