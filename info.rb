require 'ostruct'

module Info

  class Base < OpenStruct; end

  class Geo < Base; end
  
  class Twitter < Base
    def url; super; "http://www.twitter.com/#{handle}" end
  end

  class Facebook < Base
    def url; super; "http://www.facebook.com/#{handle}" end
  end

  class LinkedIn < Base
    def url; super; "http://www.linkedin.com/#{handle}" end
  end

  class Foursquare < Base
    def url; super; "http://www.foursquare.com/#{handle}" end
  end

end
