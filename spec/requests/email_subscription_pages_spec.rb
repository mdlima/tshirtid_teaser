require 'spec_helper'

describe "Home Page" do
  it "should render a page" do
    get root_path
    response.status.should be(200)
  end
  
end

describe "Email Subscription Page" do
  describe "GET /email_subscriptions" do
    it "should redirect to /" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get email_subscriptions_path
      response.should redirect_to root_path
    end
    
  end
  
  subject { page }

  describe "signup page (home)" do
    
    before { visit root_path }

    it { should have_selector('.buy-now-box') }
    it { should have_selector('.sign-up-box') }
    
    let(:submit) { "OK" }
  
    describe "Sign-up box" do
      
      it "should alert of an invalid e-mail" do

        within '.sign-up-box' do
          fill_in 'email_subscription_email', :with => 'invalid_email@'
          expect { click_button submit }.not_to change(EmailSubscription, :count)
        end
        
        should have_selector('div.alert.alert-info', :text => 'inválido')
        
      end
      
      it "should subscribe the user" do
        within '.sign-up-box' do
          fill_in 'email_subscription_email', :with => 'valid_email@email.com'
          expect { click_button submit }.to change(EmailSubscription.where(:opt_in_campaign => "teaser-signup"), :count).by(1)
        end
        should have_selector('div.alert.alert-success', :text => 'sucesso')
      end

    end
    
    describe "Buy-now box" do
    
      it "should alert of an invalid e-mail" do
      
        # save_and_open_page

        within '.buy-now-box' do
          fill_in 'email_subscription_email', :with => 'invalid_email@'
          expect { click_button submit }.not_to change(EmailSubscription, :count)
        end
      
        should have_selector('div.alert.alert-info', :text => 'inválido')
      
      end
    
      it "should subscribe the user" do
        within '.buy-now-box' do
          fill_in 'email_subscription_email', :with => 'valid_email@email.com'
          expect { click_button submit }.to change(EmailSubscription.where(:opt_in_campaign => "teaser-buynow"), :count).by(1)
        end
        should have_selector('div.alert.alert-success', :text => 'sucesso')
      end
    
    end
    
  end
  
end
