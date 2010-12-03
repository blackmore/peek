module JobsHelper
  def ratio_total(job)
    ratio_array = [ job.mystats[:ratio_subtitle],
                    job.mystats[:ratio_translation],
                    job.mystats[:ratio_proof_reading],
                    job.mystats[:ratio_quality_assurance],
                    job.mystats[:ratio_other]
    ]
    ratio_array.delete_if { |x| x.nil? }
    total = ratio_array.inject(0) { |s,v| s += v }
    total.round(1)
  end
#   
#   def output_ratio(minutes, run_length)
#     unless run_length.nil? || minutes == 0
#       (minutes/run_length.to_f).round(1)
#     else
#       "<span class='data_missing'>MISSING!</span>".html_safe
#     end
#   end
#   
#   def total_sub_minutes(minutes)
#     unless minutes.nil?
#       "#{minutes} mins"
#     else
#       "<span class='data_missing'>DATA MISSING!</span>".html_safe
#     end
#   end
#   
#   def run_length(minutes)
#     unless minutes.nil?
#       "Run Length: #{minutes} mins"
#     else
#       "Run Length: <span class='data_missing'>DATA MISSING!</span>".html_safe
#     end
#   end
#   
#   def proof_reading_ratio(proof_minutes, minutes)
#     unless proof_minutes == 0 || minutes.nil?
#       (minutes/proof_minutes.to_f).round(1)
#     end
#   end
#   
#   def son_ratio(son_minutes, minutes)
#     unless son_minutes == 0 || minutes.nil?
#       (minutes/son_minutes.to_f).round(1)
#     end
#   end
#   
#   
#   
#  def dis_average(jobs)
#     array_of_sub_rations = Array.new
#     
#     jobs.each do |job|
#       unless job.stats["r_length"].nil?
#         array_of_sub_rations << (job.stats["sub_minutes"] / job.stats["r_length"].to_f).round(2)
#       else
#         array_of_sub_rations << 0
#       end
#     end
# 
#     array_of_sub_rations.delete_if { |value| value <= 0 }
#     if array_of_sub_rations.length > 0
#       total = array_of_sub_rations.inject(0) { |s,v| s += v }
#       (total / array_of_sub_rations.length).round(2).to_s
#     else
#       "Sorry Bad data"
#     end
# 
#  end
#  
#  def son_average(jobs)
#     array_of_sub_rations = Array.new
# 
#     jobs.each do |job|
#       array_of_sub_rations << (job.stats["son_minutes"] / job.stats["r_length"].to_f).round(2)
#     end
# 
#     array_of_sub_rations.delete_if { |value| value <= 0 }
#     total = array_of_sub_rations.inject(0) { |s,v| s += v }
#     (total / array_of_sub_rations.length).round(2).to_s
#  end
#  
#  def qa_average(jobs)
#     array_of_sub_rations = Array.new
# 
#     jobs.each do |job|
#       array_of_sub_rations << (job.stats["qa_minutes"] / job.stats["r_length"].to_f).round(2)
#     end
# 
#     array_of_sub_rations.delete_if { |value| value <= 0 }
#     total = array_of_sub_rations.inject(0) { |s,v| s += v }
#     (total / array_of_sub_rations.length).round(2).to_s
#  end
#  
#  def pr_average(jobs)
#     array_of_sub_rations = Array.new
# 
#     jobs.each do |job|
#       array_of_sub_rations << (job.stats["pr_minutes"] / job.stats["r_length"].to_f).round(2)
#     end
# 
#     array_of_sub_rations.delete_if { |value| value <= 0 }
#     total = array_of_sub_rations.inject(0) { |s,v| s += v }
#     (total / array_of_sub_rations.length).round(2).to_s
#  end
  
end
