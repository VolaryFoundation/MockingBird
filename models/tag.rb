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
