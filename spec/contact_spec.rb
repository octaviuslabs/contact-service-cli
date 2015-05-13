require 'spec_helper'
require './contact'
require 'active_support/all'

module TestData

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
          "avatar": "THEAVITAR"
        }
      }
    ]
  end
end

describe Contact do
  subject do
    allow_any_instance_of(Contact).to receive(:get_data).and_return(ActiveSupport::JSON.decode(TestData.response_data))
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

end
