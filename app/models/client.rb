class Client

  include DataMapper::Resource

  # set the storage name for the :default repository
  storage_names[:default] = 'Customer'
  
  # remap to rails conventions
  property :id,             Serial,     :field => 'CustomerID'
  property :name,           String,     :field => 'Name'
  property :address,        String,     :field => 'Anschrift'
  property :street,         String,     :field => 'Strasse'
  property :plz,            String,     :field => 'PLZ'
  property :county,         String,     :field => 'Ort'
  property :country,        String,     :field => 'Land'
  property :phone_number,   String,     :field => 'Telefon'
  property :fax_number,     String,     :field => 'Fax'
  property :email,          String,     :field => 'EMail'
  property :website,        String,     :field => 'Website'
  property :contact,        String,     :field => 'Ansprechpartner'
  property :comments,       String,     :field => 'Kommentar'
  property :active,         Boolean,    :field => 'Active'
  property :updated_on,     DateTime,   :field => 'LastChanged'
  
  has n, :jobs,             :child_key => [:customerid]
  
end
