class ReadingsController < ApplicationController
    before_filter :load_readable

    def create
      @reading = @readable.readings.build(reading_params)
      if @reading.save
        @readable.has_been_read
        redirect_to [@readable.bucket.organization, @readable.bucket, @readable]
      else
        redirect_to root_path, alert: "There was an issue reading this."
      end
    end

    def destroy
      @reading = Reading.find(params[:id])
      @reading.destroy
      @readable.check_if_still_read
      redirect_to [@readable.bucket.organization, @readable.bucket, @readable]
    end

  private
  
    def reading_params
      params.require(:reading).permit(:contributor_id)
    end

    def load_readable
      resource, id = request.path.split('/')[5, 6]
      logger.debug "RESOURCE: #{resource}, ID: #{id}"
      resource = "users" if resource == "members"
      @readable = resource.singularize.classify.constantize.find(id)
      logger.debug "@readable: #{@readable}"
    end
end
