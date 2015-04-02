class ResourcesController < ApplicationController
  before_filter :instantiate_stuff
  
  def index
    @resource = Resource.new(bucket_id: @bucket.id)
  end
  
  def show
    @resource = Resource.find(params[:id])
    @next_resource = @resource.next
    @previous_resource = @resource.previous
    @tweet = Tweet.new(resource_id: @resource.id)
    @tweets = @resource.tweets
    if @resource.summarization.sentences.present?
      @suggested_tweet = @resource.summarization.sentences.shuffle.first + " " + @resource.hashtagging.hashtags.shuffle.first(rand(1..3)).join(', ')
    else
      @suggested_tweet = "n/a"
    end
  end
  
  def update
    @resource = Resource.find(params[:id])
    if @resource.update_attributes(resource_params)
      redirect_to [@organization, @resource.bucket, @resource]
    else
      redirect_to root_path, alert: "An error occurred."
    end
  end
  
  def create
    @resource = @bucket.resources.build(resource_params)
    if @resource.save
      Alien.create_extraction(@resource)
      Alien.create_summarization(@resource)
      Alien.create_hashtagging(@resource)
      redirect_to organization_bucket_resources_path(@organization, @bucket), notice: "Resource created."
    else
      redirect_to root_path, alert: "The application encountered an error."
    end
  end
  
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    redirect_to organization_bucket_resources_path(@organization, @bucket), notice: "Resource removed."
  end
  
  private 
  
    def instantiate_stuff
      @organization = Organization.find(params[:organization_id])
      @bucket = @organization.buckets.find(params[:bucket_id])
      # order by resource extraction title
      # @resources = @bucket.resources.where(archived: false).joins(:extraction).order("extractions.title ASC")
      @resources = @bucket.resources.where(archived: false).order("created_at DESC")
    end
    
    def resource_params
      params.require(:resource).permit(:name, :url, :html, :last_archived_at, :archived, :bucket_id)
    end
end
