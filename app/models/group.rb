class Group
  require 'rest_client'
  
  include MongoMapper::Document

  before_save :generate_keywords
  
  after_save :send_to_eagle

  one :location
  belongs_to :user
  belongs_to :pending_user, class_name: 'User'
  many :events
  many :links
  
  attr_accessor :skip_send_to_eagle

  ensure_index :"location.lng_lat" => '2dsphere'
  
  RANGE_OPTIONS = [ 'local', 'regional', 'national', 'international' ]
  SIZE_OPTIONS = [ nil, "No Membership", "1-10", "11-25", "26-50", "51-100",
                        "101-250","250-500", "500-1000", "1000+" ]
  STATUS_OPTIONS = ['pending', 'avtive', 'deactive', 'disabled']

  timestamps!
  key :name, required: true, unique: true
  key :description
  key :status, default: 'pending', required: true, :in => STATUS_OPTIONS
  key :size, :in => SIZE_OPTIONS
  key :keywords, Array
  key :range, range: true, :in => RANGE_OPTIONS
  key :tags, Array
  key :eagle_id
  key :user_id
  key :pending_user
  key :cor_id
  key :email
  key :memebership
  key :founded


  def claim_group(user)
    self.pending_user = user
    self.save! ? (return self) : (return nil)
  end

  def self.match_group(group)
    record = Group.all('name' => group.name)
    if record.count == 1
      return record.first
    elsif record.count == 0
      possible_links = Array.new
      group.links.each do |link|
        possible_links << link.url
        possible_links << (link.url.match('https') ? link.url.gsub('https', 'http') : link.url.gsub('http', 'https'))
        possible_links << (possible_links[0][-1] == '/' ? possible_links[0][0..-2] : "#{possible_links[0]}/")
        possible_links << (possible_links[1][-1] == '/' ? possible_links[1][0..-2] : "#{possible_links[1]}/")
        records = Group.all( {'links.url' => { :$in => possible_links } } )
        return records.first if records.count == 1
      end
    else
      possible_links = Array.new
      group.links.each do |link|
        possible_links << link.url
        possible_links << (link.url.match('https') ? link.url.gsub('https', 'http') : link.url.gsub('http', 'https'))
        possible_links << (possible_links[0][-1] == '/' ? possible_links[0][0..-2] : "#{possible_links[0]}/")
        possible_links << (possible_links[1][-1] == '/' ? possible_links[1][0..-2] : "#{possible_links[1]}/")
        records = Group.where('name' => group.name).where({'links.url' => { :$in => possible_links } } ).all
        return records.first if records.count == 1
      end
    end
    return false
  end

  def add_tags(tags)
    tags = [tags] if tags.is_a?(String)
    newTags = self.tags
    tags.each do |tag|
      newTags << tag unless newTags.include?(tag.downcase)
    end
    return newTags
  end
  
  def respond_to_claim(responce)
    responce == 'approve' ? (self.user = self.pending_user) : (self.pending_user = nil)
    self.save! ? (return self) : (return nil)
  end
  
  def send_to_eagle
    if skip_send_to_eagle 
      self.skip_send_to_eagle = false 
      return
    end
    object_to_send = [{mockingbird: self._id}, grab_urls(self.links)]
    puts object_to_send.to_json
    uri = "#{ENV['EAGLE_SERVER']}groups/refs"
    begin
      response = RestClient.post uri, object_to_send.to_json, :content_type => :json, :accept => :json
    rescue => e
      puts e
    end
    if response.present?
      self.skip_send_to_eagle = true
      add_ref_to_group(JSON.parse(response.body)['_id'])
      puts response 
    end
  end
    
  def add_ref_to_group(id)
    self.eagle_id = id
    save
  end
  
  def grab_urls(array)
    new_array = Array.new
    array.each do |item|
      new_array << item.url
    end
    return new_array
  end

  def self.keywordize str
    str.downcase.split.uniq
  end
  
  def generate_keywords
    self.keywords = self.class.keywordize("#{name} #{description}")
  end

  def self.search params={}
    query = build_query(params)
    skip = params['skip']
    limit = params['limit']
    if (skip && limit)
      where(query).skip(skip.to_i).limit(limit.to_i)
    else
      where(query).all
    end
  end

  def self.build_query params

    query = {}

    query[:keywords] = { :$in => keywordize(params[:keywords]) } if params[:keywords]
    query[:size] = { :$in => params[:sizes] } if params[:sizes]
    query[:range] = { :$in => params[:ranges] } if params[:ranges]
    query[:"location.lng_lat"] = { :$near => { :$geometry => { type: 'Point', coordinates: [ params[:geo][0].to_f, params[:geo][1].to_f ] } }, :$maxDistance => (params[:geo][2].to_f / 6371) } if params[:geo]

    if params[:tags]
      tagsOn = params[:tags].select { |k, v| v == 'require' }.keys.map(&:to_s)
      tagsOff = params[:tags].select { |k, v| v == 'reject' }.keys.map(&:to_s)
      query[:tags] = {}
      query[:tags][:$in] = tagsOn unless tagsOn.empty?
      query[:tags][:$nin] = tagsOff unless tagsOff.empty?
    end

    if params[:keys]
      query.merge! params[:keys]
    end

    query
  end
end
