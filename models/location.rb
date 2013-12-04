class Location
  include MongoMapper::EmbeddedDocument

  key :address
  key :lng_lat, Array, required: true
  key :city
  key :state
  key :postal_code
  key :country, required: true
  
  validate :city_validation, :state_validation, :postal_code_validation
  
  def city_validation
    if !address.nil? && city.nil?
      errors.add( :city, "City is required if you have an address")
    end
  end
  
  def state_validation
    if !city.nil? && state.nil?
      errors.add( :state, "State is required if you have an city")
    end
  end
  
  def postal_code_validation
    if !address.nil? && postal_code.nil?
      errors.add( :postal_code, "Postal Code is required if you have an address")
    end
  end
  
end
