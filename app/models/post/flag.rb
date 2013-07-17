# TODO: this is different from others in post folder, doesn't inherit from post

class Post::Flag
  include Mongoid::Document

  field :type, type: String
  field :user_id, type: Integer

  embedded_in :post
end