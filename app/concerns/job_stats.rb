module JobStats

  def parse_to_minutes(str)
    if str
      m = str.split(":")
      m.collect! { |x| x.to_i }
      total = m[0]*60 + m[1]
    else
      0
    end
  end

  def stats
     @job_run_length = self.description.run_length
     
     total_pr = 0
     total_dm = 0
     total_qa = 0
     total_sub = 0
     #total_tra = 0
     total_son = 0

       self.task_times.each do |t|
         case t.job_type
         when 1 then total_sub += parse_to_minutes(t.duration)
         #when 2 then total_tra += parse_to_minutes(t.duration)
         when 3 then total_pr += parse_to_minutes(t.duration)
         when 4 then total_qa += parse_to_minutes(t.duration)
         when 5 then total_dm += parse_to_minutes(t.duration)
         when 6 then total_son += parse_to_minutes(t.duration)
         end
       end
       
     Hash["r_length" => @job_run_length, "sub_minutes" => total_sub,"pr_minutes" => total_pr, "qa_minutes" => total_qa, "md_minutes" => total_dm, "son_minutes" => total_son ]
  end
    
end