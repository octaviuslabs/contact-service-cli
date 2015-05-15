require 'active_support/json'

module MrJson

  def self.decode the_json
    ActiveSupport::JSON.decode(the_json)
  end


  def self.encode the_hash
    ActiveSupport::JSON.encode(the_hash)
  end


end
