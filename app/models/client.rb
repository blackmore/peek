class Client

  include DataMapper::Resource

  # set the storage name for the :default repository
  storage_names[:default] = 'Customer'
  
  # remap to rails conventions
  property :id,             Serial,     :field => 'CustomerID'
  property :name,           String,     :field => 'Name'
  property :address,        String,     :field => 'Anschrift'       ,:lazy => true
  property :street,         String,     :field => 'Strasse'         ,:lazy => true
  property :plz,            String,     :field => 'PLZ'             ,:lazy => true
  property :county,         String,     :field => 'Ort'             ,:lazy => true
  property :country,        String,     :field => 'Land'            ,:lazy => true
  property :phone_number,   String,     :field => 'Telefon'         ,:lazy => true
  property :fax_number,     String,     :field => 'Fax'             ,:lazy => true
  property :email,          String,     :field => 'EMail'           ,:lazy => true
  property :website,        String,     :field => 'Website'         ,:lazy => true
  property :contact,        String,     :field => 'Ansprechpartner' ,:lazy => true
  property :comments,       String,     :field => 'Kommentar'       ,:lazy => true
  property :active,         Boolean,    :field => 'Active'
  property :updated_on,     DateTime,   :field => 'LastChanged'
  
  has n, :jobs,             :child_key => [:customerid]
  
  def self.all_order
    all(:order => [:name.asc])
  end
  
end
