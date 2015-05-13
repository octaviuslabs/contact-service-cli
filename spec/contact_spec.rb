require 'spec_helper'
require './contact'
require 'active_support/all'
require 'support/test_data'

describe Contact do
  subject do
    allow_any_instance_of(Contact).to receive(:get_data).and_return(TestData.to_h(TestData.response_data))
    Contact.find('dummy@email.com')
  end
  it { should be_a Contact}
  it {expect(subject.email_address).to eql "dummy@email.com"}
  it {expect(subject.id).to eql "THISISAUUID"}
  it {expect(subject.name).to eql "Dummy Person"}
  it {expect(subject.company).to eql "Dummy Company"}
  it {expect(subject.address).to eql "Pleasant Grove, UT, USA"}
  it {expect(subject.phone).to eql "THEPHONE"}
  it {expect(subject.avatar).to eql "THEAVITAR"}
  it {expect(subject.twitter).to be_a Info::Twitter}
  it {expect(subject.facebook).to be_a Info::Facebook}
  it {expect(subject.linkedin).to be_a Info::LinkedIn}
  it {expect(subject.foursquare).to be_a Info::Foursquare}

end
