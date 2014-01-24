def attribute_seperator(attribute, key)
  if attribute.kind_of?(Array)
    attribute = array_to_html(attribute)
  elsif  key == 'website'
    attribute = website_link_creator(attribute)
  elsif attribute.kind_of?(Hash) && key == 'location'
    attribute = location_to_html(attribute)
  elsif  attribute.kind_of?(Hash)
    attribute = hash_to_html(attribute)
  end
  return attribute
end

def array_to_html(attribute)
  #TODO Out put as LI in HAML Tags format
  return attribute.join(', ')
end

def hash_to_html(attribute)
  attribute_as_string = '<ul>'
  attribute.each do |key, value|
    if value.present? && !value.empty?
      attribute_as_string += "<li>#{key.titleize}: #{value}</li>"
    end
  end
  return attribute_as_string += '</ul>'
end

def object_to_html(attribute)
end

def website_link_creator(attribute)
  return "<a href=#{attribute}>#{attribute}</a>"
end

def location_to_html(attribute)
  if !attribute.kind_of?(Hash)
    hash = Hash.new
    attribute.instance_variables.each do |key| 
      hash[key.to_s.delete("@")] = attribute.instance_variable_get(key)
    end
    attribute = hash
  end
  attribute_as_array = Array.new
  attribute_as_array << "#{attribute["address"]}" if attribute.has_key?("address") && attribute["address"].present?
  attribute_as_array << "#{attribute["city"].titleize}" if attribute.has_key?("city") && attribute["city"].present?
  attribute_as_array << "#{attribute["state"].titleize}" if attribute.has_key?("state") && attribute["state"].present?
  attribute_as_array << "#{attribute["postal_code"]}" if attribute.has_key?("postal_code") && attribute["postal_code"].present?
  attribute_as_array << "#{attribute["country"].titleize}" if attribute.has_key?("country") && attribute["country"].present?
  return attribute_as_array.join(', ')
end