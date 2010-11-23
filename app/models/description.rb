class Description

  include DataMapper::Resource

  # set the storage name for the :default repository
  storage_names[:default] = 'Tracking'

  property :id,                           Serial,    :field => 'TrackingID'
  property :run_length,                   Integer,    :field => 'Duration'
  property :source_language,              Integer,    :field => 'LanguageFromID'
  property :target_language,              Integer,    :field => 'LanguageToID'
  property :authoring_house,              String,   :field => 'AuthoringHouse'
  property :studio,                       String,   :field => 'Studio'
  property :file_name,                    String,   :field => 'Filename'
  property :genre,                        String,   :field => 'ProjectType'
  property :file_path,                    String,   :field => 'Path'
  property :orig_path,                    String,   :field => 'OrigPath'
  property :translation_memory_path,      String,   :field => 'MemPath'
  property :new_translation_memory_path,  String,   :field => 'NewMemPath'
  property :comments,                     Text,    :field => 'SpecialNotes'
  property :internal_comments,            Text,    :field => 'InternalNotes'
  # property :production_id,                Integer,   :field => 'ProductionID'
  
  belongs_to :job,                        :child_key => [:productionid]


end

