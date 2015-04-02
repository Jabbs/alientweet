class TweetsController < ApplicationController
  before_filter :instantiate_stuff
  
  def create
    @tweet = @resource.tweets.new(tweet_params)
    if @tweet.save
      redirect_to [@organization, @bucket, @resource], notice: "Tweet created."
    else
      render "resources/show", alert: "Something went wrong with your tweet."
    end
  end
  
  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update_attributes(tweet_params)
      referrer = request.referer.split('/').last
      logger.debug "REFERRER: #{referrer}"
      if referrer == "buckets"
        redirect_to organization_buckets_path(@organization)
      elsif referrer == "all_resources"
        redirect_to organization_all_resources_path(@organization)
      elsif referrer == "resources"
        redirect_to organization_bucket_resources_path(@organization, @tweet.resource.bucket)
      else
        redirect_to [@organization, @tweet.resource.bucket, @tweet.resource]
      end
    else
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
  
    def instantiate_stuff
      @organization = Organization.find(params[:organization_id])
      @bucket = @organization.buckets.find(params[:bucket_id])
      @resource = @bucket.resources.find(params[:resource_id])
    end
    
    def tweet_params
      params.require(:tweet).permit(:link, :copy, :approved, :resource_id, :sent, :last_approved_at, :last_sent_at)
    end
end
