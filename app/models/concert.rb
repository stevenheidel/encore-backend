# == Schema Information
#
# Table name: concerts
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  venue_id      :integer
#  date          :date
#  created_at    :datetime
#  updated_at    :datetime
#  start_time    :datetime
#  end_time      :datetime
#  artist_id     :integer
#  populated     :boolean
#  songkick_uuid :integer
#

class Concert < ActiveRecord::Base
  belongs_to :artist #HABTM artists
  belongs_to :venue
  has_many :setlist_songs

  has_many :attendances
  has_many :users, through: :attendances

  # All the fun associations
  has_many :instagram_photos
  has_many :user_photos

  validates_uniqueness_of :songkick_uuid

  # Convert event from songkick into concert
  def self.build_from_hashie(hashie)
    if hashie.start.time
      start_time = DateTime.parse(hashie.start.date + "T" + hashie.start.time)
    else
      # TODO: Arbitrarily choose 6:00 as starting time
      start_time = DateTime.parse(hashie.start.date + "T" + "18:00:00")
    end
    # TODO: Arbitrarily add 6 hours from start time
    end_time = start_time + 6.hours

    venue = Venue.where(songkick_uuid: hashie.venue.id.to_i).first_or_create do |v|
      v.name     = hashie.venue.displayName
      v.location = hashie.location.city
      v.latitude  = hashie.location.lat
      v.longitude = hashie.location.lng
    end

    self.new({
      name: hashie.performance[0].displayName, # TODO: just the artist name
      date: hashie.start.date,
      start_time: start_time,
      end_time: end_time,
      songkick_uuid: hashie.id,
      venue: venue
    },
    :without_protection => true # TODO avoid this
    )
  end

  def posts
    self.instagram_photos + self.user_photos
  end
end
