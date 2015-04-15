class ResourcesController < ApplicationController
  before_filter :instantiate_stuff
  before_filter :correct_user
  
  def index
    @resource = Resource.new(bucket_id: @bucket.id)
  end
  
  def show
    @reading = Reading.new
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
    fix_date_month_order
    if @resource.update_attributes(resource_params)
      referrer = request.referer.split('/').last
      logger.debug "REFERRER: #{referrer}"
      if referrer == "all_resources"
        redirect_to organization_all_resources_path(@organization)
      elsif referrer == "unread_resources"
        redirect_to organization_unread_resources_path(@organization)
      elsif referrer == "approved_resources"
        redirect_to organization_approved_resources_path(@organization)
      else
        redirect_to [@organization, @resource.bucket, @resource]
      end
    else
      redirect_to root_path, alert: "An error occurred."
    end
  end
  
  def create
    fix_date_month_order
    @resource = @bucket.resources.build(resource_params)
    if @resource.save
      Alien.create_extraction(@resource)
      Alien.create_summarization(@resource)
      Alien.create_hashtagging(@resource)
      track_activity @resource
      redirect_to organization_bucket_resources_path(@organization, @bucket), notice: "Resource created."
    else
      redirect_to root_path, alert: "The application encountered an error."
    end
  end
  
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    
    referrer = request.referer.split('/').last
    logger.debug "REFERRER: #{referrer}"
    if referrer == "all_resources"
      redirect_to organization_all_resources_path(@organization)
    elsif referrer == "buckets"
      redirect_to organization_buckets_path(@organization)
    elsif referrer == "unread_resources"
      redirect_to organization_unread_resources_path(@organization)
    elsif referrer == "approved_resources"
      redirect_to organization_approved_resources_path(@organization)
    else
      redirect_to [@organization, @resource.bucket, @resource]
    end
  end
  
  private
  
    def correct_user
      redirect_to new_user_session_path unless current_user == @organization.user
    end
  
    def fix_date_month_order
      params[:resource][:article_date] = Date.strptime(params[:resource][:article_date],'%m/%d/%Y') if params[:resource][:article_date].present?
    end
  
    def instantiate_stuff
      @organization = Organization.find(params[:organization_id])
      @bucket = @organization.buckets.find(params[:bucket_id])
      # order by resource extraction title
      # @resources = @bucket.resources.where(archived: false).joins(:extraction).order("extractions.title ASC")
      @resources = @bucket.resources.where(archived: false).order("created_at DESC")
    end
    
    def resource_params
      params.require(:resource).permit(:name, :url, :html, :last_archived_at, :archived, :bucket_id, :article_date, 
                                       :contributor_id, :article_date, :approved, :last_approved_at)
    end
end
