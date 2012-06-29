require 'spec_helper'

describe EmailSubscription do

  before { @email_subscription = EmailSubscription.new(
    :name => "Example User", 
    :email => "user@example.com", 
    :opt_in => true, 
    :opt_in_campaign => "campaign", 
    :ip => "ip", 
    :last_opt_in => DateTime.new, 
    :last_opt_out => DateTime.new ) }

  subject { @email_subscription }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:opt_in) }
  it { should respond_to(:opt_in_campaign) }
  it { should respond_to(:ip) }
  it { should respond_to(:last_opt_in) }
  it { should respond_to(:last_opt_out) }
  
  it { should be_valid }

  describe "when email is not present" do
    before { @email_subscription.email = " " }
    it { should_not be_valid }
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @email_subscription.email = invalid_address
        @email_subscription.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @email_subscription.email = valid_address
        @email_subscription.should be_valid
      end      
    end
  end
  
  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @email_subscription.email = mixed_case_email
      @email_subscription.save
      @email_subscription.reload.email.should == mixed_case_email.downcase
    end
  end
  
end