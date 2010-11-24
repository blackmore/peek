class Job

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
  # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # 
  # def manager
  #  self.staff.name
  # end
  
  # source
  # target
  # from_date
  # to_date
  # category
  # client
  
  def self.finished_subtitling_jobs(params) # Subtitles only!!
    
    if params
      # if params[:start_date] = ""
      #   params[:start_date] = "01/01/2000"
      # end
      # 
      # if params[:end_date] = ""
      #   params[:end_date] = Time.now
      # end
      
      all(
          :production_status => 2,
          :category.not => (4,5), # NOT including Live and Translation
          :order => :deadline.desc,
          :created_on.gte => Chronic::parse(params[:start_date]),
          :deadline.lte => Chronic::parse(params[:end_date]),
          :client => {
                       :id => customer
          },
          :description => {
                            :source_language => params[:source].to_i,
                            :target_language => params[:target].to_i
                           }
          )
    else
      all()
    end
  end
  
  def self.finished_translation_jobs(scope, source, target)
    all(
        :production_status => 2,
        :category => 4, # Only Translation
        :order => :deadline.desc,
        :limit => scope,
        :description => {
                          :source_language => source,
                          :target_language => target
                         }
        )
  end

end
