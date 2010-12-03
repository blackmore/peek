class JobsController < ApplicationController

  def index  
     @languages = Language.all_order.collect { |p| [ p.language, p.id ] }
     @languages.unshift(["All", "All"])
     
     @clients = Client.all_order.collect { |p| [ p.name, p.id ] }
     @clients.unshift(["All", "All"])
  end
  
  def search
     @jobs = Job.filter_jobs(params[:search])
     #@job_stats = []
     # @job.each do |job|
     #  @job_stats << job.statistics
     # end
  end
  
  
  

end
