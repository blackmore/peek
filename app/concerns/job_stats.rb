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
  
  def to_ratio(minutes)
    unless minutes.nil? || self.run_length.nil? || minutes == 0 || self.run_length == 0
      (minutes/self.run_length.to_f).round(1)
    end
  end
  
  def get_ratio_total
    ratio_array = [ self.ratio_subtitle,
                    self.ratio_translation,
                    self.ratio_proof_reading,
                    self.ratio_quality_assurance,
                    self.ratio_other
    ]
    
    ratio_array.compact!
    
    unless ratio_array.empty?
      ratio_array.inject(:+).round(1) # clever way to add arrays
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
    
    self.ratio_subtitle = to_ratio(@subtitle)
    self.ratio_translation = to_ratio(@translation)
    self.ratio_proof_reading = to_ratio(@proof_reading)
    self.ratio_quality_assurance = to_ratio(@quality_assurance)
    self.ratio_other = to_ratio(@other)
    
    self.ratio_total = get_ratio_total
  end
    
end