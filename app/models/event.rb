class Event
  include MongoMapper::Document

  before_save :generate_keywords

  one :location
  belongs_to :organization
  many :links

  ensure_index :"location.lng_lat" => '2dsphere'

  PRICE_OPTIONS = [ nil, '$', '$$', '$$$', '$$$$' ]
  ATTENDANCE_OPTIONS = [ nil, "1-10", "11-25", "26-50", "51-100", "101-250","250-500", "500-1000", "1000+" ]

  timestamps!
  key :name, required: true
  key :description
  key :attendance, in: ATTENDANCE_OPTIONS
  key :price, in: PRICE_OPTIONS
  key :start_at
  key :end_at
  key :status
  key :keywords, Array
  key :tags, Array

  def serializable_hash(options = {})
    super({ :include => :organization }.merge(options))
  end

  def generate_keywords
    self.keywords = self.class.keywordize("#{name} #{description}")
  end

  def self.keywordize str
    str.downcase.split.uniq.select { |word| word.length > 2 }
  end

  def self.search params={}
    query = build_query(params)
    where(query).all
  end

  def self.build_query params

    query = {}

    query[:keywords] = { :$in => keywordize(params[:keywords]) } if params[:keywords]
    query[:attendance] = { :$in => params[:attendances] } if params[:attendances]
    query[:price] = { :$in => params[:prices] } if params[:prices]
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

