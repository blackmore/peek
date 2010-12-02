module JobStats

  def to_min(str)
    if str
      m = str.split(":")
      m.collect! { |x| x.to_i }
      total = m[0]*60 + m[1]
    else
      0
    end
  end
  
  def add_up_minutes(obj, minutes)
    unless obj.nil?
      obj += minutes
    else
      obj = minutes
    end
  end
  
  def to_ratio(minutes)
    unless minutes.nil? || @run_length.nil?
      (minutes/@run_length.to_f).round(1)
    end
  end

  def stats
     @run_length = self.description.run_length ||= nil
     
     [@subtitle, @translation, @proof_reading, @quality_assurance, @other].collect { |x| x = nil }
       self.task_times.each do |t|
         case t.job_type
         when 1 
           @subtitle = add_up_minutes(@subtitle, to_min(t.duration))
         when 2
           @translation = add_up_minutes(@translation, to_min(t.duration))
         when 3
           @proof_reading = add_up_minutes(@proof_reading, to_min(t.duration))
         when 4
           @quality_assurance = add_up_minutes(@quality_assurance, to_min(t.duration))
         when 6
           @other = add_up_minutes(@other, to_min(t.duration))
         else
           next
         end
       end
       
     @statistics = {
                      'total' => [@subtitle, @translation, @proof_reading, @quality_assurance, @other],
                      'ratio' => [to_ratio(@subtitle), to_ratio(@translation), to_ratio(@proof_reading), to_ratio(@quality_assurance), to_ratio(@other)],
                      'run_length' => @run_length
     }
     puts "hash: #{@statistics['ratio'][0]}"
     return @statistics
     #Hash["r_length" => @job_run_length, "sub_minutes" => @subtitle,"pr_minutes" => @proof_reading, "qa_minutes" => @quality_assurance, "son_minutes" => @other ]
  end
    
end
# subtitle
# translation
# proof_reading
# quality_assurance
# other
# ratio_subtitle
# ratio_translation
# ratio_proof_reading
# ratio_quality_assurance
# ratio_other
# run_length