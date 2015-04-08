class OrganizationsController < ApplicationController
  before_filter :instantiate_orgs
  respond_to :html, :js
  
  def show
    @organization = Organization.find(params[:id])
  end
  
  def index
    @organization = Organization.new
  end
  
  def unread_resources
    @organization = Organization.find(params[:organization_id])
    @resources = @organization.resources.where(read: false).order("created_at DESC")
  end
  
  def all_resources
    @organization = Organization.find(params[:organization_id])
    @resources = @organization.resources.where(archived: false).order("created_at DESC")
  end
  
  def archived_resources
    @organization = Organization.find(params[:organization_id])
    @resources = @organization.resources.where(archived: true).order("created_at DESC")
  end
  
  def approved_resources
    @organization = Organization.find(params[:organization_id])
    @resources = @organization.resources.where(approved: true).order("created_at DESC")
  end
  
  def tweet_manager
    @organization = Organization.find(params[:organization_id])
    @approved_tweets = @organization.tweets.where(disproved: false).where(approved: true).where(cleared: false).order("placement_id ASC")
  end
  
  def sent_tweets
    @organization = Organization.find(params[:organization_id])
    @sent_tweets = @organization.tweets.where(sent: true).order("created_at ASC").paginate(page: params[:page], per_page:20)
  end
  
  def clear_all_tweets
    @organization = Organization.find(params[:organization_id])
    @organization.clear_all_tweets
    redirect_to organization_tweet_manager_path(@organization)
  end
  
  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      redirect_to root_path, notice: "Organization created."
    else
      redirect_to root_path, alert: "The application encountered an error."
    end
  end
  
  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    redirect_to root_path, notice: "Organization removed."
  end
  
  private
  
    def instantiate_orgs
      @organizations = current_user.organizations.order("name ASC")
    end
    
    def organization_params
      params.require(:organization).permit(:name, :user_id, :tag_list)
    end
end
