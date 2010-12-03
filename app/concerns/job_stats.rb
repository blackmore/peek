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

  def statistics
     @run_length = self.description.run_length ||= nil
     puts "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
     #[@subtitle, @translation, @proof_reading, @quality_assurance, @other].collect { |x| x = nil }
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
                      :subtitle =>        @subtitle,
                      :translation =>     @translation,
                      :proof_reading     => @proof_reading,
                      :quality_assurance => @quality_assurance,
                      :other => @other,
                      :ratio_subtitle => to_ratio(@subtitle),
                      :ratio_translation => to_ratio(@translation),
                      :ratio_proof_reading => to_ratio(@proof_reading),
                      :ratio_quality_assurance => to_ratio(@quality_assurance),
                      :ratio_other => to_ratio(@other), 
                      :run_length => @run_length
     }
    
     return @statistics
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