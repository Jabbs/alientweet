class CommentsController < ApplicationController
  
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      referrer = request.referer.split('/').last
      logger.debug "REFERRER: #{referrer}"
      if referrer == "all_resources"
        redirect_to organization_all_resources_path(@organization), notice: "Comment created."
      elsif referrer == "unread_resources"
        redirect_to organization_unread_resources_path(@organization), notice: "Comment created."
      elsif referrer == "approved_resources"
        redirect_to organization_approved_resources_path(@organization), notice: "Comment created."
      else
        redirect_to [@organization, @resource.bucket, @resource], notice: "Comment created."
      end
    else
      redirect_to root_path, alert: "An error occurred."
    end
  end
  
  private
    def comment_params
      params.require(:comment).permit(:contributor_id, :commentable_type, :commentable_id, :body)
    end
end
