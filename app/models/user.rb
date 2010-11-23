class User

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
  def self.all_active_users
    all(:active => true, :order => [:nativelanguageid.asc, :name.asc])
  end
  
  # selects all subtitlers - translators and freelancers- group in language
  # removes DATA MANAGEMENT - defines group tags - cleans us their names
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  def self.all_active_subtrans
    users = all(:active => true, :order => [:nativelanguageid.asc, :name.asc])
    
    users.delete_if{|user| user.name =~ /ZZ/ && user.name != "ZZ Extern"}
    
    users.each do |user|
      add_role_to_group(user)
      clean_name(user)
    end
  end
  
  
  
  # finds all tasls that have their enddate >= (time)
  def all_current_tasks(time)
    Task.all(:staffid => self.id, :end_date.gt => time, :order => [:start_date.asc] )
  end
  
  def self.clean_name(user)
    user.name.gsub!(/([A-Z]\s*){2}/, "")
  end
  
  def self.add_role_to_group(user)
    if user.name =~ /XT/
      user.group << ",XST"
    else
      user.group << ",ST"
    end
  end
  

end
