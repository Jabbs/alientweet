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
    @resources = @organization.resources.where(read: false).order("created_at DESC").paginate(page: params[:page], per_page:20)
  end
  
  def all_resources
    @organization = Organization.find(params[:organization_id])
    @resources = @organization.resources.where(archived: false).order("created_at DESC").paginate(page: params[:page], per_page:20)
  end
  
  def archived_resources
    @organization = Organization.find(params[:organization_id])
    @resources = @organization.resources.where(archived: true).order("created_at DESC").paginate(page: params[:page], per_page:20)
  end
  
  def approved_resources
    @organization = Organization.find(params[:organization_id])
    @resources = @organization.resources.where(approved: true).order("created_at DESC").paginate(page: params[:page], per_page:20)
  end
  
  def tweet_manager
    @organization = Organization.find(params[:organization_id])
    @approved_tweets = @organization.tweets.where(disproved: false).where(approved: true).where(cleared: false).where(sent: false)
    # @approved_tweets = @approved_tweets.joins(:resource).order('resources.id')
    @to_send_tweets = @organization.tweets.where(disproved: false).where(approved: true).where(cleared: false).where(sent: true).order("scheduled_to_send_at ASC")
    respond_to do |format|
      format.html
      format.csv { send_data @to_send_tweets.to_csv }
    end
  end
  
  def sent_tweets
    @organization = Organization.find(params[:organization_id])
    @sent_tweets = @organization.tweets.where(sent: true).order("created_at DESC").paginate(page: params[:page], per_page:20)
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
