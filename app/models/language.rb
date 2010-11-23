class Language

  include DataMapper::Resource
  
  # set the storage name for the :default repository
  storage_names[:default] = 'Language'

  # remap to rails conventions
  property :id,            Serial,    :field => 'LanguageID'
  property :language,      String,    :field => 'Language'
  
  has n, :users,          :through => :stafflanguages
  has n, :user,           :child_key => [:nativelanguageid]
 
  def self.all_order
    all(:order => [:language.asc])
  end

end

