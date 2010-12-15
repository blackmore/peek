module JobStats

  def to_minutes(str)
    if /(\d\d):(\d\d):(\d\d)/.match str
      $1.to_i*60 + $2.to_i
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
  
  def get_ratio_total
    unless self.total_work.nil? || self.run_length.nil? || self.run_length == 0
      (self.total_work/self.run_length.to_f).round(1)
    end
  end
  
  def add_array_values(array)
    array.compact!
    
    unless array.empty?
      array.inject(:+) # clever way to add arrays
    end
  end

  def statistics
     self.run_length = self.description.run_length ||= nil
     
       self.task_times.each do |t|
         case t.job_type
         when 1 
           @subtitle = add_up_minutes(@subtitle, to_minutes(t.duration))
         when 2
           @translation = add_up_minutes(@translation, to_minutes(t.duration))
         when 3
           @proof_reading = add_up_minutes(@proof_reading, to_minutes(t.duration))
         when 4
           @quality_assurance = add_up_minutes(@quality_assurance, to_minutes(t.duration))
         when 6
           @other = add_up_minutes(@other, to_minutes(t.duration))
         else
           next
         end
       end
       
    self.subtitle_mins = @subtitle
    self.translation_mins = @translation
    self.proof_reading_mins = @proof_reading
    self.quality_assurance_mins = @quality_assurance
    self.other_mins = @other
    self.total_work = add_array_values([@subtitle, @translation, @proof_reading, @quality_assurance, @other])
    
    self.ratio_total = get_ratio_total
  end
    
end