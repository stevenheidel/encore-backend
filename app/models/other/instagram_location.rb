# == Schema Information
#
# Table name: instagram_locations
#
#  id             :uuid             not null, primary key
#  name           :string(255)
#  instagram_uuid :integer
#  venue_id       :uuid
#  created_at     :datetime
#  updated_at     :datetime
#

require 'foursquare_api'
require 'instagram_api'

class Other::InstagramLocation < ActiveRecord::Base
  belongs_to :venue

  validates_uniqueness_of :instagram_uuid

  def self.find_instagram_ids_for_venue(venue)
    instagram_locations = []

    # First get all the ones from Foursquare
    FoursquareAPI.search_venues(venue.name, venue.latitude, venue.longitude).each do |v|
      instagram_locations << InstagramAPI.foursquare_location(v.id).first
    end
    instagram_locations.compact! # in case some foursquare finds didn't match up

    # Then do an Instagram Search on the venue latitude and longitude
    InstagramAPI.location_search(venue.latitude, venue.longitude).each do |l|
      # TODO: magic number
      if string_similarity(l.name, venue.name) > 0.25
        instagram_locations << l
      end
    end

    # Then go through each found location and search around it as well
    to_be_searched = instagram_locations.compact.uniq{|s| s.id}
    while (l = to_be_searched.shift)
      InstagramAPI.location_search(l.latitude, l.longitude).each do |ll|
        if string_similarity(ll.name, venue.name) > 0.25
          instagram_locations << ll
        end
      end
    end
    instagram_locations.uniq!{|s| s.id}

    # Then save them all to the database
    instagram_locations.each do |il|
      record = self.new
      record.instagram_uuid = il[:id]
      record.name = il[:name]
      venue.instagram_locations << record
    end
  end

  private

    # http://stackoverflow.com/questions/653157/a-better-similarity-ranking-algorithm-for-variable-length-strings
    def self.string_similarity(string1, string2)
      str1 = string1.downcase
      pairs1 = (0..str1.length-2).collect {|i| str1[i,2]}.reject {
        |pair| pair.include? " "}
      str2 = string2.downcase
      pairs2 = (0..str2.length-2).collect {|i| str2[i,2]}.reject {
        |pair| pair.include? " "}
      union = pairs1.size + pairs2.size
      intersection = 0
      pairs1.each do |p1|
        0.upto(pairs2.size-1) do |i|
          if p1 == pairs2[i]
            intersection += 1
            pairs2.slice!(i)
            break
          end
        end
      end
      score = (2.0 * intersection) / union
    end
end
