class ResourcesController < ApplicationController
  before_filter :instantiate_stuff
  
  def index
    @resources = @organization.resources
    @resource = Resource.new(organization_id: @organization.id)
  end
  
  def show
    @resource = Resource.find(params[:id])
  end
  
  def create
    @resource = @organization.resources.build(resource_params)
    if @resource.save
      redirect_to organization_resources_path(@organization), notice: "Resource created."
    else
      redirect_to root_path, alert: "The application encountered an error."
    end
  end
  
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    respond_to do |format|
      format.js
    end
  end
  
  private 
  
    def instantiate_stuff
      @organization = Organization.find(params[:organization_id])
      @resources = @organization.resources
    end
    
    def resource_params
      params.require(:resource).permit(:name, :url, :body)
    end
end
