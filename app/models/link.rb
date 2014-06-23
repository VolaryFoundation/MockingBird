class Link
  include MongoMapper::EmbeddedDocument

  key :url, required: true
  key :name, required: true
  key :type

  def self.url_connect?(url)
    new_url = url
    new_url = url_set_http(new_url) if !new_url.starts_with?('http')
    begin
      responce = RestClient.get(new_url)
    rescue
      new_url = url_secure_switch(new_url)
      begin
        responce = RestClient.get(new_url)
      rescue
      end
    end
    if responce.present? && responce.code == 200
      return ((new_url != url) ? {code: 200, status: 'changed', url: new_url} : {code: 200, status: true, url: url})
    elsif responce.present? && responce.code != 200
      return [responce.code, false, url]
    else
      return {code: 400, status: false, url: url}
    end
  end

    
    private

    def self.url_set_http(url)
      if !url.starts_with?('http')
        new_url = "http://#{url}"
        return new_url
      else
        return url
      end
    end


    def self.url_secure_switch(url)
      if !url.starts_with?('http')
        return nil
      else
        if url.starts_with?('http://')
          new_url = url.gsub('http', 'https')
        elsif url.starts_with?('https://')
          new_url = url.gsub('https', 'http')
        end
        return new_url
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
