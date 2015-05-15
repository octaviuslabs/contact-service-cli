module TestData

  def self.to_h json_data
    ActiveSupport::JSON.decode(json_data)
  end

  def self.twitter_json
    %[{"handle": "jsfour",
      "id": 516172716,
      "bio": "THIS IS MY BIO",
      "followers": 7337,
      "following": 25,
      "statuses": 1000,
      "favorites": 994,
      "location": "LA",
      "site": "MYSITEINFO",
      "avatar": "http://mi.avatar.com/img/foo.gif"}
    ]
  end

  def self.facebook_json
    %[{"handle": "jsfour"}]
  end

  def self.linkedin_json
    %[{"handle": "in/jsfour"}]
  end

  def self.foursquare_json
    %[{"handle": "jsfour"}]
  end

  def self.contact_response
    %[
      {
      "contact": {
          "type": "contact",
          "id": "THISISAUUID",
          "email_address": "dummy@email.com",
          "name": "Dummy Person",
          "company": "Dummy Company",
          "address": "Pleasant Grove, UT, USA",
          "phone": "THEPHONE",
          "contact_type": "prospect",
          "avatar": "THEAVITAR",
          "facebook": #{facebook_json},
          "twitter": #{twitter_json},
          "linkedin": #{linkedin_json},
          "foursquare": #{foursquare_json}
        }
      }
    ]
  end

  def self.response_data
    %[
      {
      "prospect": {
          "type": "contact",
          "id": "THISISAUUID",
          "email_address": "dummy@email.com",
          "name": "Dummy Person",
          "company": "Dummy Company",
          "address": "Pleasant Grove, UT, USA",
          "phone": "THEPHONE",
          "contact_type": "prospect",
          "avatar": "THEAVITAR",
          "facebook": #{facebook_json},
          "twitter": #{twitter_json},
          "linkedin": #{linkedin_json},
          "foursquare": #{foursquare_json}
        }
      }
    ]
  end
end
