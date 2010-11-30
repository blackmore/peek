module JobsHelper
  
  def output_ratio(taken_minutes, run_length)
    unless run_length == 1
    ratio = (taken_minutes/run_length.to_f).round(2)
  else
    "SORRY BAD DATA"
  end
  end
  
 def dis_average(jobs)
    array_of_sub_rations = Array.new
    
    jobs.each do |job|
      unless job.stats["r_length"] == 1
        array_of_sub_rations << (job.stats["sub_minutes"] / job.stats["r_length"].to_f).round(2)
      else
        array_of_sub_rations << 0
      end
    end

    array_of_sub_rations.delete_if { |value| value <= 0 }
    if array_of_sub_rations.length > 0
      total = array_of_sub_rations.inject(0) { |s,v| s += v }
      (total / array_of_sub_rations.length).round(2).to_s
    else
      "Sorry Bad data"
    end

 end
 
 def son_average(jobs)
    array_of_sub_rations = Array.new

    jobs.each do |job|
      array_of_sub_rations << (job.stats["son_minutes"] / job.stats["r_length"].to_f).round(2)
    end

    array_of_sub_rations.delete_if { |value| value <= 0 }
    total = array_of_sub_rations.inject(0) { |s,v| s += v }
    (total / array_of_sub_rations.length).round(2).to_s
 end
 
 def qa_average(jobs)
    array_of_sub_rations = Array.new

    jobs.each do |job|
      array_of_sub_rations << (job.stats["qa_minutes"] / job.stats["r_length"].to_f).round(2)
    end

    array_of_sub_rations.delete_if { |value| value <= 0 }
    total = array_of_sub_rations.inject(0) { |s,v| s += v }
    (total / array_of_sub_rations.length).round(2).to_s
 end
 
 def pr_average(jobs)
    array_of_sub_rations = Array.new

    jobs.each do |job|
      array_of_sub_rations << (job.stats["pr_minutes"] / job.stats["r_length"].to_f).round(2)
    end

    array_of_sub_rations.delete_if { |value| value <= 0 }
    total = array_of_sub_rations.inject(0) { |s,v| s += v }
    (total / array_of_sub_rations.length).round(2).to_s
 end
  
end
