require 'spec_helper'
require './info'
require 'support/test_data'

module Info
  describe LinkedIn do
    subject do
      LinkedIn.new(TestData.to_h(TestData.linkedin_json))
    end
    it { expect(subject.handle).to eql "in/jsfour" }
    it { expect(subject.url).to eql "http://www.linkedin.com/in/jsfour"}
  end

  describe Facebook do
    subject do
      Facebook.new(TestData.to_h(TestData.facebook_json))
    end
    it { expect(subject.handle).to eql "jsfour" }
    it { expect(subject.url).to eql "http://www.facebook.com/jsfour"}
  end

  describe Foursquare do
    subject do
      Foursquare.new(TestData.to_h(TestData.foursquare_json))
    end
    it { expect(subject.handle).to eql "jsfour" }
    it { expect(subject.url).to eql "http://www.foursquare.com/jsfour"}

  end

  describe Twitter do
    subject do
      Twitter.new(TestData.to_h(TestData.twitter_json))
    end
    it { should respond_to(:handle) }
    it { should respond_to(:id) }
    it { should respond_to(:bio) }
    it { should respond_to(:following) }
    it { should respond_to(:followers) }
    it { should respond_to(:statuses) }
    it { should respond_to(:favorites) }
    it { should respond_to(:location) }
    it { should respond_to(:avatar) }
    it { expect(subject.handle).to eql "jsfour" }
    it { expect(subject.id).to eql 516172716 }
    it { expect(subject.bio).to eql "THIS IS MY BIO" }
    it { expect(subject.followers).to eql 7337 }
    it { expect(subject.following).to eql 25 }
    it { expect(subject.statuses).to eql 1000 }
    it { expect(subject.favorites).to eql 994 }
    it { expect(subject.location).to eql "LA" }
    it { expect(subject.site).to eql "MYSITEINFO" }
    it { expect(subject.avatar).to eql "http://mi.avatar.com/img/foo.gif" }
    it { expect(subject.url).to eql "http://www.twitter.com/jsfour"}



  end
end
