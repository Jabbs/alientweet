class ResourcesController < ApplicationController
  before_filter :instantiate_stuff
  
  def index
    @resources = @bucket.resources
    @resource = Resource.new(bucket_id: @bucket.id)
  end
  
  def show
    @resource = Resource.find(params[:id])
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
      @resources = @bucket.resources
    end
    
    def resource_params
      params.require(:resource).permit(:name, :url, :html)
    end
end
