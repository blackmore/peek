class JobsController < ApplicationController

  def index  
     @languages = Language.all_order.collect { |p| [ p.language, p.id ] }
     @languages.unshift(["All", "All"])
     
     @clients = Client.all_order.collect { |p| [ p.name, p.id ] }
     @clients.unshift(["All", "All"])
  end
  
  def search
     @jobs = Job.filter_jobs(params[:search])
     @jobs.collect { |job| job.statistics }
     
    ##############################
    # Table with Constructor Format
    data_array = []
    @jobs.each do |job|
      # sub_total = job.subtitle_mins + job.translation_mins + job.proof_reading_mins + job.quality_assurance_mins + other_mins
      
      row_hash = {:c => []}
      row_hash[:c] << {:v => "<a href='http://10.1.1.246/production/tracking.php?action=load&ProductionID=#{job.id}'>#{job.title}</a>"}
      row_hash[:c] << set_v_and_f(job.run_length, "mins")
      row_hash[:c] << {:v => job.deadline }
      row_hash[:c] << set_v_and_f(job.subtitle_mins, "mins")
      row_hash[:c] << set_v_and_f(job.translation_mins, "mins")
      row_hash[:c] << set_v_and_f(job.proof_reading_mins, "mins")
      row_hash[:c] << set_v_and_f(job.quality_assurance_mins, "mins")
      row_hash[:c] << set_v_and_f(job.other_mins, "mins")
      row_hash[:c] << set_v_and_f(total_minutes(job), "mins")
      row_hash[:c] << set_v_and_f(job.ratio_total, "1 :")
      
      data_array << row_hash
      
    end
    
    @chart = GoogleVisualr::Table.new({
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
      @chart.send "#{key}=", value
    end
    #@scatter_chart = scatter_chart
    @scatter_chart02 = scatter_02
  end
  
  private
  
  def set_v_and_f(*arg)
    unless arg[0].nil?
      if arg.include?("1 :")
        Hash[:v => arg[0], :f => " #{arg[1]} #{arg[0]}"]
      else
        Hash[:v => arg[0], :f => "#{arg[0]} #{arg[1]}"]
      end
    else
      Hash[:v => 0, :f => "-"]
    end
  end
  
  def total_minutes(job)
    array = [ job.subtitle_mins,
              job.translation_mins,
              job.proof_reading_mins,
              job.quality_assurance_mins,
              job.other_mins
            ]
    
    array.compact!
    
    unless array.empty?
      array.inject(:+) # clever way to add arrays
    else
      nil
    end
  end
  

  def scatter_02
    data_array02 = []
    jobs_reversed = @jobs.reverse
     jobs_reversed.each do |job|
        # sub_total = job.subtitle_mins + job.translation_mins + job.proof_reading_mins + job.quality_assurance_mins + other_mins
        unless job.ratio_total.nil?
          row_hash = {:c => [job.deadline, job.ratio_total ]}
          data_array02 << row_hash
        end
        

      end
    
    @chart_scatter02 = GoogleVisualr::ScatterChart.new({
               :cols =>  [ 
                           { :id => 'date', :label => 'Date'  , :type => 'date' },
                           { :id => 'ratio', :label => 'Ratio', :type => 'number' }
                          ],
               :rows =>  data_array02
            })
            options = { :height => 350, :width => 600,  :titleX => 'Date', :titleY => 'Ratio', :legend => 'none', :pointSize => 5 }
            options.each_pair do | key, value |
              @chart_scatter02.send "#{key}=", value
            end
  end
end
