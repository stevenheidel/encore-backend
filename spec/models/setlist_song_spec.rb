# == Schema Information
#
# Table name: setlist_songs
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  itunes_link :string(255)
#  concert_id  :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe SetlistSong do
  pending "add some examples to (or delete) #{__FILE__}"
end
