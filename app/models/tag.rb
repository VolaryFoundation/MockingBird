class Tag
  include MongoMapper::Document

  key :name

  # [ 'a.b.c', 'a.b.d' ] ==>> { a: { b: { c: { }, d: {} } } }
  def self.asHash(strings)

    strings.reduce({}) do |hash, string| 

      last = hash
      last_key = nil

      string.split('.').each do |part|

        if last_key
          last[last_key][part] ||= {}
          last = last[last_key]
        else
          last[part] ||= {}
          last = last
        end

        last_key = part
      end

      hash
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
