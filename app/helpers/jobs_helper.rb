module JobsHelper
  
  def get_total(arr)
    unless arr.empty?
      arr.inject(:+)
    end
  end
  
  def total_minutes(jobs)
    minutes = []
    jobs.each do |job|
      minutes << job.run_length
    end
    minutes.compact!
    total_minutes = get_total(minutes)
  end
  
  def total_work_time(jobs)
    minutes = []
    jobs.each do |job|
      minutes << job.total_work
    end
    minutes.compact!
    total_minutes = get_total(minutes)
  end
  
  def format_to_hours(minutes)
    if minutes > 60
      quotient, remainder = minutes.divmod(60)
      "#{quotient}h #{remainder.to_i}m"
    else
      "#{minutes}m"
    end
  end
  
  def average_ratio(time, work)
    (work/time).round(1)
  end
  
  def total_stats(jobs)
    total_minutes = total_minutes(jobs)
    total_work = total_work_time(jobs)
    
    return total_minutes, total_work, average_ratio(total_minutes, total_work)
  end
  
  def get_averages(arr)
    arr.compact!
    unless arr.empty?
      "Max: 1:#{arr.max} Min: 1:#{arr.min} Average: 1:#{(get_total(arr)/arr.length).round(1)}"
    else
      "No Data"
    end
  end
  
  def average_ratio_subtitles(jobs)
    ratio_arr = []
    jobs.collect { |job| ratio_arr << job.ratio_subtitle }
    get_averages(ratio_arr)
  end
  
  def average_ratio_proof_reading(jobs)
    ratio_arr = []
    jobs.collect { |job| ratio_arr << job.ratio_proof_reading }
    get_averages(ratio_arr)
  end
  
  def average_ratio_quality_assurance(jobs)
    ratio_arr = []
    jobs.collect { |job| ratio_arr << job.ratio_quality_assurance }
    get_averages(ratio_arr)
  end
  
  def average_ratio_other(jobs)
    ratio_arr = []
    jobs.collect { |job| ratio_arr << job.ratio_other }
    get_averages(ratio_arr)
  end
  
  def average_ratio_total(jobs)
    ratio_arr = []
    jobs.collect { |job| ratio_arr << job.ratio_total }
    get_averages(ratio_arr)
  end
  
  def average_ratio_translation(jobs)
    ratio_arr = []
    jobs.collect { |job| ratio_arr << job.ratio_translation }
    get_averages(ratio_arr)
  end
  
  def chart_date(obj)
    myArray = obj.map {|job| job.ratio_total}
    myArray.compact!
    myArray.reverse!
    myArray.inspect
  end
   
end
