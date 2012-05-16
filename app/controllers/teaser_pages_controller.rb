class TeaserPagesController < ApplicationController
  def home
    @email_subscription = EmailSubscription.new
    
    # flash[:notice] = {:message => 'Flash notice.', :heading => "Notice."}
    # flash[:alert] = 'Flash alert.'
    # flash[:error] = 'Flash error.'
    # flash[:success] = 'Flash success.'
  end

end
