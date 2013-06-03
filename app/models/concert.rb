# == Schema Information
#
# Table name: concerts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  venue_id   :integer
#  date       :date
#  created_at :datetime
#  updated_at :datetime
#  start_time :datetime
#  end_time   :datetime
#

class Concert < ActiveRecord::Base
  has_one :time_capsule # may be changed to has_many later
  belongs_to :venue

  after_commit :times_from_eventful

  private

  def times_from_eventful
    return if self.start_time or self.end_time

    EventfulFiller.perform_async(:concert, self.id)
  end
end
