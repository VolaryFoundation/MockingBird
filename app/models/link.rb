class Link
  include MongoMapper::EmbeddedDocument

  key :url, required: true
  key :name, required: true
  key :type
  
end