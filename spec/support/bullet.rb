# require 'bullet'

# RSpec.configure do |config|
#   config.before(:each) do
#     Bullet.start_request if Bullet.enable?
#   end

#   config.after(:each) do
#     if Bullet.enable? && Bullet.notification?
#       Bullet.perform_out_of_channel_notifications
#     end
#     Bullet.end_request if Bullet.enable?
#   end
# end