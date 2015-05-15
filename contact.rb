require 'rubygems'
require './hashable'
require 'ostruct'
require './info'
require './networkable'
require './mr_json'
require 'pry'

class Contact
  include Hashable
  include Networkable

  attr_reader :email_address,
              :id,
              :name,
              :company,
              :address,
              :geo,
              :phone,
              :avatar,
              :twitter,
              :linkedin,
              :foursquare,
              :facebook,
              :response

  def initialize params
    params = wrap_hash(params)
    load_data params
  end

  def self.find id=nil
    return false unless id
    contact = new(id: id)
    contact.response
    return contact
  end

  def get!
    return response unless response.nil?
    data = get_data
    data = data.fetch("contact"){ Hash.new }
    data["twitter"] = Info::Twitter.new(de_hash(data.fetch("twitter"){ Hash.new }))
    data["linkedin"] = Info::LinkedIn.new(de_hash(data.fetch("linkedin"){ Hash.new }))
    data["foursquare"] = Info::Foursquare.new(de_hash(data.fetch("foursquare"){ Hash.new }))
    data["facebook"] = Info::Facebook.new(de_hash(data.fetch("facebook"){ Hash.new }))
    data["geo"] = Info::Geo.new(de_hash(data.fetch("geo"){ Hash.new }))
    load_data(data)
    @response = wrap_response(data)
    return self
  end

  private

  # Placeholder to wrap eval to fix ruby hash coming from server
  # todo: Remove This!!!
  def de_hash item=""
    item = item.to_s
    eval(item)
  end

  def load_data data=Hash.new
    # @response ||= data.fetch("response"){ nil }
    @email_address ||= data.fetch("email_address"){ nil }
    @id ||= data.fetch("id"){ nil }
    @name ||= data.fetch("name"){ nil }
    @company ||= data.fetch("company"){ nil }
    @address ||= data.fetch("address"){ nil }
    @geo ||= data.fetch("geo"){ nil }
    @phone ||= data.fetch("phone"){ nil }
    @avatar ||= data.fetch("avatar"){ nil }
    @twitter ||= data.fetch("twitter"){ nil }
    @linkedin ||= data.fetch("linkedin"){ nil }
    @foursquare ||= data.fetch("foursquare"){ nil }
    @facebook ||= data.fetch("facebook"){ nil }
    return self
  end

  def get_data
    return @get_data unless @get_data.nil?
    data = network.get do |req|
      req.url "v1/contacts/#{id}"
      req.headers['Authorization'] = %[Token token=#{Networkable.api_key}]
      req.headers['Content-Type'] = %[application/json]
    end
    @get_data = MrJson.decode(data.body)
  end

  def wrap_response response
    OpenStruct.new(response)
  end

  # Sample response from server
  # {
  #     "prospect": {
  #         "type": "contact",
  #         "id": "1bf8639b-c81c-4663-8e13-77b4202051bf",
  #         "email_address": "kenbarlo@icloud.com",
  #         "name": "Ken Barlow",
  #         "company": null,
  #         "address": "Pleasant Grove, UT, USA",
  #         "phone": null,
  #         "contact_type": "prospect",
  #         "avatar": "https://d1ts43dypk8bqh.cloudfront.net/v1/avatars/55481440-0301-4d6a-9c15-f0b9e1264f2f",
  #         "facebook": "{\"handle\"=>\"kenneth.m.barlow\"}",
  #         "twitter": "{\"handle\"=>\"kenbarlo\", \"id\"=>516172716, \"bio\"=>\"Loves Tech News, Reading, Business, Traveling, Movies, Running and Weight Lifting. Developer & Designer of iOS/Android @izeni. Student @UVU.\", \"followers\"=>219, \"following\"=>779, \"statuses\"=>1126, \"favorites\"=>994, \"location\"=>\"Pleasant Grove, UT\", \"site\"=>nil, \"avatar\"=>\"https://pbs.twimg.com/profile_images/532457217610366976/GavqRaUO.jpeg\"}",
  #         "linkedin": "{\"handle\"=>\"in/kenbarlo\"}",
  #         "foursquare": "{\"handle\"=>nil}"
  #     }
  # }

end
