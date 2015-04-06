class ApplicationController < ActionController::Base
  # http_basic_authenticate_with :name => "learnmetrics", :password => "brooklyn99"
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :instantiate_new_comment
  
  def instantiate_new_comment
    @comment = Comment.new
  end
end
