# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  facebook_uuid :integer
#  oauth_string  :string(255)
#  oauth_expiry  :datetime
#  name          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end
