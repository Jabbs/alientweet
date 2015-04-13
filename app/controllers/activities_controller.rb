class ActivitiesController < ApplicationController
  before_filter :instantiate_stuff
  before_filter :correct_user
  
  
  
  private
  
    def correct_user
      redirect_to new_user_session_path unless current_user == @organization.user
    end
  
    def instantiate_stuff
      @organization = Organization.find(params[:organization_id])
    end
end
