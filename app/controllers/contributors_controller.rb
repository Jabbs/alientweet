class ContributorsController < ApplicationController
  before_filter :instantiate_stuff
  before_filter :correct_user
  
  def index
  end
  
  def show
    @contributor = Contributor.find(params[:id])
  end
  
  def create
    @contributor = @organization.contributors.new(contributor_params)
    if @contributor.save
      redirect_to organization_buckets_path(@organization), notice: "Contributor created."
    else
      redirect_to root_path, alert: "The application encountered an error."
    end
  end
  
  def update
    @contributor = Contributor.find(params[:id])
    if @contributor.update_attributes(contributor_params)
      redirect_to organization_buckets_path(@organization)
    else
      redirect_to root_path, alert: "An error occurred."
    end
  end
  
  def destroy
    @contributor = Contributor.find(params[:id])
    @contributor.destroy
    redirect_to organization_buckets_path(@organization), notice: "Contributor removed."
  end
  
  private
  
    def correct_user
      redirect_to new_user_session_path unless current_user == @organization.user
    end
  
    def instantiate_stuff
      @organization = Organization.find(params[:organization_id])
      @buckets = @organization.buckets.order("name ASC")
    end
    
    def contributor_params
      params.require(:contributor).permit(:name)
    end
end
