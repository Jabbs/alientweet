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
      redirect_to organization_resources_path(@organization)
    else
      redirect_to root_path, alert: "An error occurred."
    end
  end
  
  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to [@organization, @bucket, @resource], notice: "Tweet removed."
  end
  
  private 
  
    def instantiate_stuff
      @organization = Organization.find(params[:organization_id])
      @bucket = @organization.buckets.find(params[:bucket_id])
      @resource = @bucket.resources.find(params[:resource_id])
    end
    
    def tweet_params
      params.require(:tweet).permit(:link, :copy, :approved, :resource_id)
    end
end
