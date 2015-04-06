class BucketsController < ApplicationController
  before_filter :instantiate_stuff
  before_filter :correct_user
  
  def index
    @bucket = Bucket.new(organization_id: @organization.id)
    @contributor = Contributor.new(organization_id: @organization.id)
    @contributors = @organization.contributors.order("name ASC")
    @tweets = @organization.tweets
    @disproved_tweets = @tweets.where(disproved: true)
    @unapproved_tweets = @tweets.where(disproved: false).where(approved: false).where(sent: false)
    @approved_tweets = @tweets.where(disproved: false).where(approved: true).where(sent: false)
  end
  
  def show
    @bucket = Bucket.find(params[:id])
  end
  
  def create
    @bucket = @organization.buckets.new(bucket_params)
    if @bucket.save
      redirect_to organization_buckets_path(@organization), notice: "Bucket created."
    else
      redirect_to root_path, alert: "The application encountered an error."
    end
  end
  
  def update
    @bucket = Bucket.find(params[:id])
    if @bucket.update_attributes(bucket_params)
      redirect_to organization_buckets_path(@organization)
    else
      redirect_to root_path, alert: "An error occurred."
    end
  end
  
  def destroy
    @bucket = Bucket.find(params[:id])
    @bucket.destroy
    redirect_to organization_buckets_path(@organization), notice: "Bucket removed."
  end
  
  private
  
    def correct_user
      redirect_to new_user_session_path unless current_user == @organization.user
    end
  
    def instantiate_stuff
      @organization = Organization.find(params[:organization_id])
      @buckets = @organization.buckets.order("name ASC")
    end
    
    def bucket_params
      params.require(:bucket).permit(:name)
    end
end
