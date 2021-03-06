class JobsController < ApplicationController
  
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # DUCK ARRAY
  class Array
    def count_by(&block)
      Hash[*group_by(&block).collect{|x,g| [x,g.size]}.flatten]
    end
  end
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  def index  
    @languages = Language.all_order.collect { |p| [ p.language, p.id ] }
    @languages.unshift(["All", "All"]) 
    
    @clients = Client.all_order.collect { |p| [ p.name, p.id ] }
    @clients.unshift(["All", "All"])
  end
  
  def search
    @jobs = Job.filter_jobs(params[:search])
    @jobs.collect { |job| job.statistics }
    
    # build google charts
    @chart = build_table
    @chart_scatter = build_scatter_chart
    # @chart_pie = build_pie_chart
  end
  
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # PRIVATE
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
  private
  
  def set_v_and_f(*arg)
    unless arg[0].nil?
      Hash[:v => arg[0], :f => "#{arg[0]} #{arg[1]}"]
    else
      Hash[:v => 0, :f => "-"]
    end
  end
  
  def total_minutes(job)
    array = [ job.subtitle_mins, job.translation_mins, job.proof_reading_mins, job.quality_assurance_mins, job.other_mins ].compact!
    
    unless array.empty?
      array.inject(:+) # clever way to add arrays
    else
      nil
    end
  end
  
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # BUILD TABLE
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  def build_table
    
    data_array = []
    @jobs.each do |job|
      row_hash = {:c => []}
      row_hash[:c] << {:v => "<a href='http://10.1.1.246/production/tracking.php?action=load&ProductionID=#{job.id}'>#{job.title}</a>"}
      row_hash[:c] << set_v_and_f(job.run_length, "mins")
      row_hash[:c] << {:v => job.deadline }
      row_hash[:c] << set_v_and_f(job.subtitle_mins, "mins")
      row_hash[:c] << set_v_and_f(job.translation_mins, "mins")
      row_hash[:c] << set_v_and_f(job.proof_reading_mins, "mins")
      row_hash[:c] << set_v_and_f(job.quality_assurance_mins, "mins")
      row_hash[:c] << set_v_and_f(job.other_mins, "mins")
      row_hash[:c] << set_v_and_f(job.total_work, "mins")
      row_hash[:c] << set_v_and_f(job.ratio_total, ": 1")
      
      data_array << row_hash
    end
    
    chart = GoogleVisualr::Table.new({
               :cols =>  [ 
                           { :id => 'title', :label => 'Title'  , :type => 'string' },
                           { :id => 'run_length', :label => 'Length', :type => 'number' },
                           { :id => 'deadline', :label => 'Deadline', :type => 'date' },
                           { :id => 'sub_total', :label => 'SUB', :type => 'number'   },
                           { :id => 'trans_total', :label => 'TRA', :type => 'number'   },
                           { :id => 'pr_total', :label => 'PR', :type => 'number'   },
                           { :id => 'qa_total', :label => 'QA', :type => 'number'   },
                           { :id => 'mis_total', :label => 'MIS', :type => 'number'   },
                           { :id => 'total_mins', :label => 'Total', :type => 'number'   },
                           { :id => 'ratio_total', :label => 'Ratio', :type => 'number'   }
                          ],
               :rows =>  data_array
            })

    options = { :allowHtml => true }
    
    options.each_pair do | key, value |
      chart.send "#{key}=", value
    end
    return chart
    
  end
  
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # BUILD SCATTER GRAPH
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  def build_scatter_chart
    data_array = []
    jobs_reversed = @jobs.reverse
    
    jobs_reversed.each do |job|
      unless job.ratio_total.nil? || job.ratio_total > 40
        row_hash = {:c => [job.deadline, job.ratio_total ]}
        data_array << row_hash
      end
    end
    
    chart = GoogleVisualr::ScatterChart.new({
                          :cols =>  [ 
                            { :id => 'date', :type => 'date' },
                            { :id => 'ratio', :label => 'Ratio', :type => 'number' }
                            ],
                          :rows =>  data_array
                          })
                      
    options = { :height => 300,  :width => 800, :axisFontSize => 10, :min => 5,  :titleY => 'Ratio', :legend => 'none', :pointSize => 3, :colors => ['rgba(16,110,211,0.53)'] }
    
    options.each_pair do | key, value |
      chart.send "#{key}=", value
    end
    
    return chart
  end
  

  
  # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # # BUILD PIE CHART
  # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # def build_pie_chart
  #   
  # 
  #   
  #   pie_group = @jobs.collect { |job| job.ratio_total }
  #   puts pie_group.inspect
  #   
  #   pie_group.count_by do |ratio|
  #     case ratio
  #     when (0..10) then :under_ten
  #     when (10..15) then :ten_fifteen
  #     when (15..20) then :fifteen_twenty
  #     when (20..25) then :twenty_twentyfive
  #     when (25..1000) then :over_25
  #     end 
  #   end
  #   puts pie_group.inspect
  #   
  #   # chart = GoogleVisualr::PieChart.new({
  #   #                       :cols =>  [ 
  #   #                         { :id => 'ratio', :type => 'string' },
  #   #                         { :id => 'ratio', :label => 'Ratio', :type => 'number' }
  #   #                         ],
  #   #                       :rows =>  [
  #   #                                  {:c => ['under_ten', pie_group[:under_ten]}
  #   #                         ]
  #   #                       })
  #   # 
  #   # options = { :width => 400, :height => 240, :title => 'My Daily Activities', :is3D => true }
  #   # 
  #   # options.each_pair do | key, value |
  #   #   chart.send "#{key}=", value
  #   # end
  #   # 
  #   # return chart    
  #   
  # end

  
end
