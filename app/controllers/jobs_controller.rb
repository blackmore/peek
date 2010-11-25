class JobsController < ApplicationController

  def index
     @languages = Language.all_order
     @clients = Client.all_order
  end
  
  def search
     @jobs = Job.filter_jobs(params[:search])
  end
  
  

end
