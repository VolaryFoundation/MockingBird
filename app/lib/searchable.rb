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
