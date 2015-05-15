require './mr_json'

class CsvOutput
  attr_reader :filename

  def initialize filename="output.csv"
    @filename = filename
    build_first_row
  end

  def build_first_row
    ::CSV.open(filename, "wb") do |csv|
      csv << [
        "avatar",
        "id",
        "email_address",
        "name",
        "company",
        "address",
        "geo",
        "phone",
        "facebook.handle",
        "linkedin.handle",
        "twitter.handle",
        "twitter.followers",
        "twitter.following",
        "twitter.bio"
      ]
    end
  end

  def write_item contact
    ::CSV.open(filename, "ab") do |csv|
      csv << [
        contact.avatar,
        contact.id,
        contact.email_address,
        contact.name,
        contact.company,
        contact.address,
        MrJson.encode(contact.geo.to_h),
        contact.phone,
        contact.facebook.handle,
        contact.linkedin.handle,
        contact.twitter.handle,
        contact.twitter.followers,
        contact.twitter.following,
        contact.twitter.bio
      ]
    end
  end
end
