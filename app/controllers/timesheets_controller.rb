class TimesheetsController < ApplicationController
  before_filter :instantiate_stuff
  before_filter :correct_user
  
  def index
    @approved_tweets = @organization.tweets.where(disproved: false).where(approved: true).where(sent: false)
    @sent_tweets = @organization.tweets.where(sent: true)
    @timesheet = Timesheet.new
    @timesheets = @organization.timesheets
  end
  
  def create
    fix_date_month_order
    @timesheet = Timesheet.new(timesheet_params)
    if @timesheet.save
      redirect_to organization_timesheets_path(@organization), notice: "Timesheet created."
    else
      redirect_to root_path, alert: "The application encountered an error."
    end
  end
  
  private
  
    def fix_date_month_order
      params[:timesheet][:day_start] = Date.strptime(params[:timesheet][:day_start],'%m/%d/%Y') if params[:timesheet][:day_start].present?
      params[:timesheet][:day_end] = Date.strptime(params[:timesheet][:day_end],'%m/%d/%Y') if params[:timesheet][:day_end].present?
    end
  
    def correct_user
      redirect_to new_user_session_path unless current_user == @organization.user
    end
  
    def instantiate_stuff
      @organization = Organization.find(params[:organization_id])
      @timesheets = @organization.timesheets.order("name ASC")
    end
    
    def timesheet_params
      params.require(:timesheet).permit(:organization_id, :day_start, :day_end, :tweets_per_day, :time_slot1,
                                        :time_slot2, :time_slot3, :time_slot4)
    end
end