class Job
  include JobStats
  attr_accessor :mystats
  
  include DataMapper::Resource

  # set the storage name for the :default repository
  storage_names[:default] = 'Production'

  # remap to rails conventions
  property :id,                 Serial,    :field => 'ProductionID'
  property :production_number,  String,    :field => 'ProductionNo'
  property :category,           Integer,   :field => 'CategoryID'
  property :title,              String,    :field => 'Title'
  property :production_status,  Integer,   :field => 'StatusID'
  property :deadline,           DateTime,  :field => 'Deadline'
  property :not_before,         DateTime,  :field => 'NotBefore'
  property :created_on,         DateTime,  :field => 'CreatedDate'
  property :updated_on,         DateTime,  :field => 'LastChanged'
  property :created_by,         Integer,   :field => 'CreatedByID'
  # property :staff_id,           Integer,   :field => 'ManagerID'
  # property :customer_id,        Integer,   :field => 'CustomerID'
  
  has 1, :description,          :child_key => [:productionid]
  has n, :task_times,           :child_key => [:productionid]
  has n, :tasks,                :child_key => [:productionid]
  belongs_to :client,           :child_key => [:customerid]
  belongs_to :user,             :child_key => [:managerid]
  

  # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  private
  def self.get_stats(col)
    col.each do |job|
      job.mystats = job.statistics
    end
  end
  
  def self.filter_jobs(params)
     conditions = {:production_status => 2, :order => :deadline.desc,  }

      unless params[:start_date].blank? 
        conditions["deadline.gte"] = Chronic::parse(params[:start_date])
      else
        conditions["deadline.gte"] = Chronic::parse("01/01/1990")
      end
      
      unless params[:end_date].blank? 
        conditions["deadline.lte"] = Chronic::parse(params[:end_date])
      else
        conditions["deadline.lte"] = Time.now
      end
      
      unless params[:source] == "All"
        conditions[:description] = {:source_language => params[:source].to_i}
      end
      
      unless params[:target] == "All"
        if conditions.has_key?(:description)
          conditions[:description].merge!({:target_language => params[:target].to_i})
        else
          conditions[:description] = {:target_language => params[:target].to_i}
        end
      end
      
      unless params[:client] == "All"
        conditions[:client] = {:id => params[:client]}
      end
      
      unless params[:title].blank?
        conditions["title.like"] = "%#{params[:title]}%"
      end
      
      categories = params[:category].delete_if { |x| x == "" }
      unless categories.empty?
        conditions[:category] = categories
      else
        conditions[:category] = [1,2,3,6]
      end
      
    get_stats(all(conditions))
  end
  
end
