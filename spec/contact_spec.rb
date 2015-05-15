require 'spec_helper'
require './contact'
require 'active_support/all'
require 'support/test_data'

shared_examples "a contact" do
  it { should be_a Contact}
  it { should respond_to :email_address }
  it { should respond_to :id }
  it { should respond_to :name }
  it { should respond_to :company }
  it { should respond_to :address }
  it { should respond_to :phone }
  it { should respond_to :avatar }
  it { should respond_to :twitter }
  it { should respond_to :facebook }
  it { should respond_to :linkedin }
  it { should respond_to :foursquare }
end

describe Contact do
  describe "#find" do
    subject do
      allow_any_instance_of(Contact).to receive(:get_data).and_return(TestData.to_h(TestData.response_data))
      Contact.find('THISISANID')
    end
    it_behaves_like "a contact"
    it {expect(subject.email_address).to eql "dummy@email.com"}
    it {expect(subject.id).to eql "THISISANID"}
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

  describe "#new" do
    subject do
      contact = Contact.new(email_address: 'dummy@email.com')
      contact
    end
    it_behaves_like "a contact"
    it {expect(subject.email_address).to eql "dummy@email.com"}
  end

end
