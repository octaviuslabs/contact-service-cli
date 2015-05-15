require 'rubygems'
require 'active_support/hash_with_indifferent_access'

module Hashable
  def wrap_hash hash_to_wrap=Hash.new
    ActiveSupport::HashWithIndifferentAccess.new(hash_to_wrap)
  end
end
