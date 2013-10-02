class Other::Flag < ActiveRecord::Base
  field :type, type: String

  belongs_to :user
  belongs_to :post
end