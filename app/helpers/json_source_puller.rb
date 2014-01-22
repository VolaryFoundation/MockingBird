def source_puller(source_name, json_object)
  return_hash = Hash.new
  json_object['props'].each do |key, prop|
    prop.each do |value|
      if value["source"] == source_name
        return_hash[key] = value['value']
      end
    end    
  end
  return return_hash
end