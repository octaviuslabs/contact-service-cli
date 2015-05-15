require 'rubygems'
require 'faraday'
require 'logger'
require 'faraday/detailed_logger'

module Networkable
  ENDPOINT = ENV["VESPER_ENDPOINT"]
  APIKEY = ENV["VESPER_KEY"]

  def self.endpoint
    ENDPOINT
  end

  def self.api_key
    APIKEY
  end

  def self.log
    return @log unless @log.nil?
    @log = ::Logger.new('network.log')
    @log.level = Logger::INFO
    return @log
  end

  def network
    @network ||= Faraday.new(:url => Networkable.endpoint) do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.response :detailed_logger, Networkable.log
      faraday.request :retry, max: 3, interval: 0.05, backoff_factor: 2
    end
    return @network
  end

end
