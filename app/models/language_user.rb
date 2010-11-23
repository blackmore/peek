class LanguageUser

   include DataMapper::Resource
  
      storage_names[:default] = 'StaffLanguage'
    
      property :user_id,    Integer, :field => 'StaffID',      :key => true, :min => 1
      property :language_id, Integer, :field => 'LanguageID',  :key => true, :min => 1
   
      belongs_to :user,    :key => true
      belongs_to :language, :key => true


end
