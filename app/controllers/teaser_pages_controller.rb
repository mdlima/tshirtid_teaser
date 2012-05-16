class TeaserPagesController < ApplicationController
  def home
    @email_subscription = EmailSubscription.new
  end
end
