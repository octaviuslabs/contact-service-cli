require 'rubygems'
require 'active_support/all'
require 'ostruct'
require './info'
require './spec/support/test_data'

class Contact
  attr_reader :email_address,
              :id,
              :name,
              :company,
              :address,
              :phone,
              :avatar,
              :twitter,
              :linkedin,
              :foursquare,
              :facebook

  def initialize params
    load_data params
  end

  def self.find email_address=nil
    return false unless email_address
    contact = new(email_address: email_address)
    contact.response
    return contact
  end

  def response
    return @response unless @response.nil?
    @response = get_data
    @response = @response.fetch("prospect"){ Hash.new }
    @response["twitter"] = Info::Twitter.new(@response.fetch("twitter"){ Hash.new })
    @response["linkedin"] = Info::LinkedIn.new(@response.fetch("linkedin"){ Hash.new })
    @response["foursquare"] = Info::Foursquare.new(@response.fetch("foursquare"){ Hash.new })
    @response["facebook"] = Info::Facebook.new(@response.fetch("facebook"){ Hash.new })
    load_data(@response)
    @response = wrap_response(@response)
  end

  private

  def load_data data=Hash.new
    @response ||= data.fetch("response"){ nil }
    @email_address ||= data.fetch("email_address"){ nil }
    @id ||= data.fetch("id"){ nil }
    @name ||= data.fetch("name"){ nil }
    @company ||= data.fetch("company"){ nil }
    @address ||= data.fetch("address"){ nil }
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
    # This should pull from the network using https://github.com/lostisland/faraday
    data = TestData.response_data
    @get_data = ActiveSupport::JSON.decode(data)
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
