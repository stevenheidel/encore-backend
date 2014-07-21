require 'json'
require 'pp'

namespace :encore do
  desc "Export the database OF USERS to be imported into Scala's MongoDB database"
  task :export_users => :environment do
    users = User.last(10).map do |user|
      hash = { 
        :name => user.name,
        :facebook_id => user.facebook_id.to_i,
        :oauth => user.oauth_string,
        :expiration_date => user.oauth_expiry.to_s,
        :email => user.email_cache,
        :invite_sent =>  user.invite_sent,
        :invite_timestamp => user.invite_timestamp.to_s,
        :events => user.events.map {|e| e.lastfm_id.to_i}
      }

      hash.reject{|k,v| v.blank?}
    end

    puts users.to_json
  end
end