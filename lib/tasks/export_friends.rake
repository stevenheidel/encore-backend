require 'json'
require 'pp'

namespace :encore do
  desc "Export the database OF FRIENDS to be imported into Scala's MongoDB database"
  task :export_friends => :environment do
    hash = Hash.new

    Event::FriendVisitor.first(100).map do |friend|
      k = [friend.user.facebook_id.to_i, friend.event.lastfm_id.to_i]
      v = friend.friend.facebook_id.to_i

      if hash.has_key?(k)
        vs = hash.fetch(k) << v
        hash.store(k, vs)
      else
        hash.store(k, [v])
      end
    end

    friends = hash.to_a.map do |a|
      {
        :facebook_id => a[0][0],
        :event_id => a[0][1],
        :friend_ids => a[1]
      }
    end

    puts friends.to_json
  end
end