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
