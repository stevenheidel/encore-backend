json.array! @friends do |user|
  json.facebook_id user.facebook_id
  json.invite_sent user.invited?
end