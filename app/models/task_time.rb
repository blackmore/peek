class TaskTime

  include DataMapper::Resource

  # set the storage name for the :default repository
  storage_names[:default] = 'TimeTracking'

  # remap to rails conventions
  property :id,            Serial,    :field => 'TimeTrackingID'
  property :created_on,    DateTime,  :field => 'Date'
  property :duration,      String,    :field => 'Duration'
  property :job_type,      Integer,   :field => 'TypeID'
  property :weigth,        Float,     :field => 'Wert'
  property :comment,       String,    :field => 'Comment'
  # property :production_id, Integer,   :field => 'ProductionID'
  # property :staff_id,      Integer,   :field => 'StaffID'
  
  belongs_to :job,        :child_key => [:productionid]
  belongs_to :user,       :child_key => [:staffid]


end

