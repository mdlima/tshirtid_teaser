require 'spec_helper'

describe "Home Page" do
  it "should render a page" do
    get root_path
    response.status.should be(200)
  end
  
end

describe "EmailSubscriptions" do
  describe "GET /email_subscriptions" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get email_subscriptions_path
      response.status.should redirect_to root_path
    end
  end
  
  
  
  
end
