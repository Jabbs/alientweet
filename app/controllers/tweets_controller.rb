class TweetsController < ApplicationController
  before_filter :instantiate_stuff
  before_filter :correct_user
  
  def create
    @tweet = @resource.tweets.new(tweet_params)
    if @tweet.save
      redirect_to [@organization, @bucket, @resource], notice: "Tweet created."
    else
      render "resources/show", alert: "Something went wrong with your tweet."
    end
  end
  
  def move
    @tweet = Tweet.find(params[:tweet_id])
    if params[:up]
      @tweet.move_up
    elsif params[:down]
      @tweet.move_down
    end
    redirect_to organization_tweet_manager_path(@organization)
  end
  
  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update_attributes(tweet_params)
      @tweet.check_approved_and_add_placement
      referrer = request.referer.split('/').last
      logger.debug "REFERRER: #{referrer}"
      if referrer == "buckets"
        redirect_to organization_buckets_path(@organization)
      elsif referrer == "unread_resources"
        redirect_to organization_unread_resources_path(@organization)
      elsif referrer == "all_resources"
        redirect_to organization_all_resources_path(@organization)
      elsif referrer == "approved_resources"
        redirect_to organization_approved_resources_path(@organization)
      elsif referrer == "tweet_manager"
        redirect_to organization_tweet_manager_path(@organization)
      elsif referrer == "resources"
        redirect_to organization_bucket_resources_path(@organization, @tweet.resource.bucket)
      else
        redirect_to [@organization, @tweet.resource.bucket, @tweet.resource]
      end
    else
      logger.debug "TWEET ERRORS: #{@tweet.errors.full_messages}"
      redirect_to root_path, alert: "An error occurred."
    end
  end
  
  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    referrer = request.referer.split('/').last
    if referrer == "buckets"
      redirect_to organization_buckets_path(@organization)
    elsif referrer == "all_resources"
      redirect_to organization_all_resources_path(@organization), notice: "Tweet removed."
    elsif referrer == "resources"
      redirect_to organization_bucket_resources_path(@organization, @tweet.resource.bucket), notice: "Tweet removed."
    else
      redirect_to [@organization, @tweet.resource.bucket, @tweet.resource], notice: "Tweet removed."
    end
  end
  
  private
  
    def correct_user
      redirect_to new_user_session_path unless current_user == @organization.user
    end
  
    def instantiate_stuff
      @organization = Organization.find(params[:organization_id])
      @bucket = @organization.buckets.find(params[:bucket_id])
      @resource = @bucket.resources.find(params[:resource_id])
    end
    
    def tweet_params
      params.require(:tweet).permit(:link, :copy, :approved, :resource_id, :sent, :last_approved_at, :last_sent_at, :contributor_id, 
                                    :disproved, :last_disproved_at)
    end
end
