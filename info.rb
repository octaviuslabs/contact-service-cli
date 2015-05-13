require 'ostruct'

module Info

  class Base < OpenStruct
  end

  class Twitter < Base; end
  class Facebook < Base; end
  class LinkedIn < Base; end
  class Forsquare < Base; end

end
