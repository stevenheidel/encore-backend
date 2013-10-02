module Concerns::Postable
  extend ActiveSupport::Concern
  
  included do
    belongs_to :event
    has_many :flags, class_name: "Other::Flag"

    validates_uniqueness_of :link, scope: :event
  end

  def add_flag(type, user_id)
    self.flags.create(type: type, user_id: user_id)
    #TODO: self.destroy with paranoid
  end
end