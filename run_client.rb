require 'csv'
require "./contact"

module Constants
  VESPERTOKEN = ENV["VESPERTOKEN"]
  def self.vesper_token
    VESPERTOKEN
  end
end

class Processor
  attr_reader :emails, :contacts

  def initialize emails
    @emails = emails
    @contacts = Array.new
  end

  def bootstrap_contacts
    emails[0...100].each do |email|
      add_contact email
    end
    return contacts
  end

  def add_contact email
    puts "Adding #{email}\n"
    contact = ::Contact.find('email')
    @contacts << contact
    return contact
  end

  def self.from_csv input_file="./input.csv", email_column=0
    puts "Reading Emails\n"
    emails = Array.new
    CSV.foreach(input_file) do |row|
      emails << row[email_column]
    end
    processor = new(emails)
    return processor
  end

  def store_contacts filename='./temp.csv'
    puts "Storing ID's And Emails"
    ::CSV.open(filename, "wb") do |csv|
      contacts.each do |contact|
        csv << [
          contact.id,
          contact.email_address
        ]
      end
    end
    return contacts
  end

  def persist
    puts "Saving Data"
    write_csv "./output.csv"
  end

private
  def write_csv filename="./output.csv"
    raise "No Contacts" if contacts.empty?
    ::CSV.open(filename, "wb") do |csv|
      csv << [
        "photo",
        "vesper_id",
        "email_address",
        "name",
        "company",
        "location",
        "phone",
        "github-public_repos",
        "github-followers",
        "linkedin",
        "twitter",
        "twitter-followers",
        "bio"
      ]
      contacts.each do |contact|
        csv << [
          contact.avatar,
          contact.id,
          contact.email_address,
          contact.name,
          contact.company,
          contact.address,
          contact.phone,
          contact.linkedin.handle,
          contact.twitter.handle,
          contact.twitter.followers,
          contact.twitter.bio
        ]
      end
    end
  end
end

contacts = Array.new
processor = Processor.from_csv('./input.csv')
processor.bootstrap_contacts
processor.store_contacts
processor.persist
