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

##=========================================================================##
## This file is part of MockingBird.                                       ##
##                                                                         ##
## MockingBird is Copyright 2014 Volary Foundation and Contributors        ##
##                                                                         ##
## MockingBird is free software: you can redistribute it and/or modify it  ##
## under the terms of the GNU Affero General Public License as published   ##
## by the Free Software Foundation, either version 3 of the License, or    ##
## at your option) any later version.                                      ##
##                                                                         ##
## MockingBird is distributed in the hope that it will be useful, but      ##
## WITHOUT ANY WARRANTY; without even the implied warranty of              ##
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU       ##
## Affero General Public License for more details.                         ##
##                                                                         ##
## You should have received a copy of the GNU Affero General Public        ##
## License along with MockingBird.  If not, see                            ##
## <http://www.gnu.org/licenses/>.                                         ##
##=========================================================================##
