class EmailSubscriptionsController < ApplicationController
  # GET /email_subscriptions
  # GET /email_subscriptions.json
  def index
    @email_subscriptions = EmailSubscription.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @email_subscriptions }
    end
  end

  # GET /email_subscriptions/1
  # GET /email_subscriptions/1.json
  def show
    @email_subscription = EmailSubscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @email_subscription }
    end
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

  # GET /email_subscriptions/1/edit
  def edit
    @email_subscription = EmailSubscription.find(params[:id])
  end

  # POST /email_subscriptions
  # POST /email_subscriptions.json
  def create
    @email_subscription = EmailSubscription.new(params[:email_subscription])
    @email_subscription.ip = request.remote_ip
    if  @email_subscription.opt_in
      @email_subscription.last_opt_in = Time.now
    else
      @email_subscription.last_opt_out = Time.now
    end
    

    respond_to do |format|
      if @email_subscription.save
        format.html { redirect_to @email_subscription, :notice => 'Email subscription was successfully created.' }
        format.json { render :json => @email_subscription, :status => :created, :location => @email_subscription }
      else
        format.html { redirect_to root_path }
        format.json { render :json => @email_subscription.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /email_subscriptions/1
  # PUT /email_subscriptions/1.json
  def update
    @email_subscription = EmailSubscription.find(params[:id])

    respond_to do |format|
      if @email_subscription.update_attributes(params[:email_subscription])
        format.html { redirect_to @email_subscription, :notice => 'Email subscription was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @email_subscription.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /email_subscriptions/1
  # DELETE /email_subscriptions/1.json
  def destroy
    @email_subscription = EmailSubscription.find(params[:id])
    @email_subscription.destroy

    respond_to do |format|
      format.html { redirect_to email_subscriptions_url }
      format.json { head :no_content }
    end
  end
end
