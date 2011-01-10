class User
  attr_accessor :mother_tongue, :current_jobs, :stacked_jobs, :role

  include DataMapper::Resource
  
  storage_names[:default] = 'Staff'

  property :id,       Serial,    :field => 'StaffID'
  property :group,    String,    :field => 'GroupID'
  property :name,     String,    :field => 'Name'
  property :active,   Boolean,   :field => 'Active'
  # property :language_id,   Integer
  
  has n, :task_times,     :child_key => [:staffid]
  has n, :jobs,           :child_key => [:managerid]
  has n, :tasks,          :child_key => [:staffid]
  belongs_to :language,   :child_key => [:nativelanguageid]
  has n, :languages,      :through   => :stafflanguages
  
    
  
  
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
  # selects all active users - groupe in languages
  def self.get_active
    users = all(:active => true, :order => [:name.asc] )
    
    users.each do |user|
      user.mother_tongue = set_mother_tongue(user)
      user.role = set_role(user.name)
      user.name = clean_name(user.name)
      user.current_jobs = set_job_count(user.id, 2)
      user.stacked_jobs = set_job_count(user.id, 1)
    end
    return users
  end


  private
  
  def self.set_job_count(user, status)
    Task.count(:staffid => user, :task_status => status )
  end
  
  def self.clean_name(name)
    name.gsub(/([A-Z]\s*){2}/, "")
  end
  
  def self.set_mother_tongue(user)
    unless user.language.nil?
      user.language.language
    else
      "-"
    end
  end
  
  def self.set_role(name)
    case name
      when /XT/
        "xst"
      when /ZZ/
        "management"
      else "st"
    end
  end

  
  

end
