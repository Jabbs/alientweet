class BucketsController < ApplicationController
  before_filter :instantiate_stuff
  
  def index
    @bucket = Bucket.new(organization_id: @organization.id)
  end
  
  def show
    @bucket = Bucket.find(params[:id])
  end
  
  def create
    @bucket = @organization.buckets.new(bucket_params)
    if @bucket.save
      redirect_to organization_buckets_path(@organization), notice: "Bucket created."
    else
      redirect_to root_path, alert: "The application encountered an error."
    end
  end
  
  def destroy
    @bucket = Bucket.find(params[:id])
    @bucket.destroy
    redirect_to organization_buckets_path(@organization), notice: "Bucket removed."
  end
  
  private
  
    def instantiate_stuff
      @organization = Organization.find(params[:organization_id])
      @buckets = @organization.buckets
    end
    
    def bucket_params
      params.require(:bucket).permit(:name)
    end
end
