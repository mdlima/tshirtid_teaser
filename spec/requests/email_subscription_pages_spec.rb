require 'spec_helper'

describe "Home Page" do
  it "should render a page" do
    get root_path
    response.status.should be(200)
  end
  
end

describe "EmailSubscriptions" do
  describe "GET /email_subscriptions" do
    it "should redirect to /" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get email_subscriptions_path
      response.should redirect_to root_path
    end
    
  end
  
  describe "Signing up" do
    it "should open the subscription page"
    it "should alert of an invalid e-mail"
    it "should subscribe the user to sign-up campaign"
    it "should subscribe the user to buy-now campaign"
  end
  
  
end
