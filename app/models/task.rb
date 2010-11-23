class Task

  include DataMapper::Resource

  # set the storage name for the :default repository
  storage_names[:default] = 'Task'

  # remap to rails conventions
  property :id,                 Serial,    :field => 'TaskID'
  property :position,           Integer,   :field => 'Position'
  property :duration,           String,    :field => 'Duration'
  property :task_status,        Integer,   :field => 'StatusID'
  property :start_date,         DateTime,  :field => 'StartDate'
  property :end_date,           DateTime,  :field => 'EndDate'
  property :comment,            String,    :field => 'Notes'
  property :description,        Integer,   :field => 'FunctionID'
  
  # property :staff_id,           Integer,   :field => 'StaffID'
  # property :production_id,      Integer,   :field => 'ProductionID'
  
  belongs_to :job,             :child_key => [:productionid]
  belongs_to :user,            :child_key => [:staffid]


end