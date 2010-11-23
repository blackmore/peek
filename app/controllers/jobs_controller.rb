class JobsController < ApplicationController
  def index
     @jobs = Job.finished_subtitling_jobs(params[:search])
  end

end
