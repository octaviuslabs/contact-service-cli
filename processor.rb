require 'csv'
require "./contact"
require "./contact_list"
require './progressive'
require 'colorize'

class Processor
  include Progressive
  attr_reader :emails, :contacts

  def initialize contact_list
    @contacts = contact_list
    puts "Loaded #{contacts.count} contacts\n".colorize(:green)
  end

  def self.build_by_emails input_file="./input.csv", email_column=0
    puts "Reading Emails\n"
    contacts = ::ContactList.new
    CSV.foreach(input_file) do |row|
      email = row[email_column]
      contacts << ::Contact.new(email_address: email)
    end
    return new(contacts)
  end

  def self.build_by_ids input_file="./contact_list.csv", id_column=0
    puts "Reading IDs\n"
    contacts = ::ContactList.new
    CSV.foreach(input_file) do |row|
      id = row[id_column]
      contacts << ::Contact.new(id: id)
    end
    return new(contacts)
  end

  def write_csv! filename="./output.csv"
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
