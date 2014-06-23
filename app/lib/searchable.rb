module SC::ElasticSearch
  extend self

  def index model, opts={}
    client.index({
      index: index_name,
      type: type(model.class)
    }.merge(opts))
  end

  def search model_class, opts={}
    results client.search({
      index: index_name,
      type: type(model_class)
    }.merge(opts))
  end

  private

    def client
      ES[:client]
    end

    def index_name
      ES[:index_name]
    end

    def type klass
      klass.name.downcase
    end

    def results res
      res['hits']['hits'].map { |h| h['_source'] }
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
