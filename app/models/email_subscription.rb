class EmailSubscription < ActiveRecord::Base
  attr_accessible :email, :ip, :last_opt_in, :last_opt_out, :name, :opt_in, :opt_in_campaign
end
