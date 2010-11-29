class JobsController < ApplicationController

  def index  
     @languages = Language.all_order.collect { |p| [ p.language, p.id ] }
     @languages.unshift(["All", "All"])
     
     @clients = Client.all_order.collect { |p| [ p.name, p.id ] }
     @clients.unshift(["All", "All"])
  end
  
  def search
    @batch = []
     @jobs = Job.filter_jobs(params[:search])
     @jobs.each do |job|
       total_pr = 0
       total_dm = 0
       total_qa = 0
       total_sub = 0
       total_tra = 0
       total_son = 0
       
       job.task_times.each do |t|
         case t.job_type
         when 1 then total_sub =+ parse_to_minutes(t.duration)
         when 2 then total_tra =+ parse_to_minutes(t.duration)
         when 3 then total_pr =+ parse_to_minutes(t.duration)
         when 4 then total_qa =+ parse_to_minutes(t.duration)
         when 5 then total_dm =+ parse_to_minutes(t.duration)
         when 6 then total_son =+ parse_to_minutes(t.duration)
         end
       end
       @batch << Hash[:job => job, :sub_minutes => total_sub, :tra_minutes => total_tra, :pr_minutes => total_pr, :total_qa => total_qa, :md_minutes => total_dm, :son_minutes => total_son ]
       puts "- #{job.title} TOTAL_SUB (#{total_sub}), TOTAL_PR (#{total_pr}), TOTAL_SON (#{total_son})"
       puts "- - - - - - - - "

     end
  end
  
  private
  def parse_to_minutes(str)
    if str
      m = str.split(":")
      m.collect! { |x| x.to_i }
      total = m[0]*60 + m[1]
    else
      0
    end
  end
  
  

end
