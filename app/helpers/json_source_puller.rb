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
