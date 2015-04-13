class CommentsController < ApplicationController
  before_filter :instantiate_stuff
  
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      track_activity @comment
      referrer = request.referer.split('/')
      logger.debug "REFERRER: #{referrer}"
      if referrer.last(2).first == "resources"
        @resource = @bucket.resources.find(params[:resource_id])
        redirect_to [@organization, @bucket, @resource], notice: "Comment created."
      elsif referrer.last == "resources"
        redirect_to organization_bucket_resources_path(@organization, @bucket), notice: "Comment created."
      elsif referrer.last == "all_resources"
        redirect_to organization_all_resources_path(@organization), notice: "Comment created."
      elsif referrer.last == "unread_resources"
        redirect_to organization_unread_resources_path(@organization), notice: "Comment created."
      elsif referrer.last == "approved_resources"
        redirect_to organization_approved_resources_path(@organization), notice: "Comment created."
      else
        redirect_to organization_buckets_path(@organization), notice: "Comment created."
      end
    else
      redirect_to root_path, alert: "An error occurred."
    end
  end
  
  private
    def comment_params
      params.require(:comment).permit(:contributor_id, :commentable_type, :commentable_id, :body)
    end
    
    def instantiate_stuff
      @organization = Organization.find(params[:organization_id])
      @bucket = @organization.buckets.find(params[:bucket_id])
    end
end
