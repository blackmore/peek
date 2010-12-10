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
    if total_minutes > 60
      quotient, remainder = total_minutes.divmod(50)
      "#{quotient}h #{remainder.to_i}m"
    else
      "#{total_minutes}m"
    end
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
