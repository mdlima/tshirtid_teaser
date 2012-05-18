class EmailSubscriptionsController < ApplicationController
  
  def index
    redirect_to root_path
  end
  
  def thanks
    
  end
  
  # GET /email_subscriptions/new
  # GET /email_subscriptions/new.json
  def new
    @email_subscription = EmailSubscription.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @email_subscription }
    end
  end

  # POST /email_subscriptions
  # POST /email_subscriptions.json
  def create
    @email_subscription = EmailSubscription.new(params[:email_subscription])
    @email_subscription.ip = request.remote_ip
    @email_subscription.opt_in = true
    @email_subscription.last_opt_in = Time.now

    respond_to do |format|
      if @email_subscription.save
        format.html { 
          flash[:success] = { :heading => "Oh yeah!", :message => 'Email cadastrado com sucesso.'}
          redirect_to thanks_path 
          }
        format.json { render :json => @email_subscription, :status => :created, :location => @email_subscription }
      else
        format.html {
          flash.now[:notice] = { :heading => 'Ooops!', :message => @email_subscription.errors[:email] }
          render :new 
          }
        format.json { render :json => @email_subscription.errors, :status => :unprocessable_entity }
      end
    end
  end

end
