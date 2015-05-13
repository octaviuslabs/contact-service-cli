require 'ostruct'

module Info

  class Base < OpenStruct
    def url
      raise "URL Not Specified"
    end
  end
  class Twitter < Base
    def url; "http://www.twitter.com/#{handle}" end
  end

  class Facebook < Base
    def url; "http://www.facebook.com/#{handle}" end
  end

  class LinkedIn < Base
    def url; "http://www.linkedin.com/#{handle}" end
  end

  class Foursquare < Base
    def url; "http://www.foursquare.com/#{handle}" end
  end

end
