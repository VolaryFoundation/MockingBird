class Link
  include MongoMapper::EmbeddedDocument

  key :url, required: true
  key :name, required: true
  
end