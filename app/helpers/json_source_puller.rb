def source_puller(source_name, json_object)
  return_hash = Hash.new
  json_object['_meta']['fields'].each do |key, prop|
    prop.each do |value|
      if value["source"] == source_name
        return_hash[key] = value['value']
      end
    end
  end
  json_object['_refs'].each do |ref|
    return_hash['ref'] = ref['id'] if ref['adapter'] == source_name
  end

  return return_hash
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
