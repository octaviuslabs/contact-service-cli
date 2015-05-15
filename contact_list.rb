require 'rubygems'
require './hashable'
require './networkable'
require './progressive'
require './csv_output'
require './mr_json'
require 'colorize'
require 'pry'

class ContactList < Array
  include Networkable
  include Hashable
  include Progressive

  def save_item item, filename='./contact_list.csv'
    raise "No Item" if item.empty?
    ::CSV.open(filename, "ab") do |csv|
      csv << [
        item.fetch("id"){"na"},
        item.fetch("email_address"){"na"}
      ]
    end
  end

  def find_all!
    puts "Finding All Contacts By ID".colorize(:green)
    sleep_time = 0
    slice = self
    bar = Progressive.new(slice.count)
    csv = CsvOutput.new('output.csv')
    slice.each do |contact|
      contact.get!
      csv.write_item contact
      bar.increment
      sleep(sleep_time)
    end
    return self
  end

  def push_all!
    puts "Pushing All Contacts To Server".colorize(:green)
    push_to_server
  end

private
  def normalized
    @normalized ||= inject(Array.new) do |memo, i|
      memo << {
        email: i.email_address
      }
    end
  end

  def push_to_server
    puts "Pushing Emails To Server".colorize(:green)
    csv = CsvOutput.new('contact_list.csv')
    sleep_time = 0
    items = normalized
    items_per_push = 100
    responses = Array.new
    progress = Progressive.new(items.count/items_per_push)
    until items.count == 0 do
      set = items.shift(items_per_push)
      response = push_set(set)
      responses << response
      if response.success?
        progress.increment
        contacts = MrJson.decode(response.body)["prospects"]
        contacts.each do |contact|
          csv.write_item Contact.new(contact)
        end
      end
      sleep(sleep_time)
    end
    return responses.flatten
  end

  # Expected Post
  # {"prospects": [{"email": "djurek@gmail.com", "name": "Danny Jurek"}, {"email": "test2@test.co"}]}
  def push_set items
    response = network.post do |req|
      req.url "v1/prospects"
      req.body = MrJson.encode({ prospects: items })
      req.headers['Authorization'] = %[Token token=#{Networkable.api_key}]
      req.headers['Content-Type'] = %[application/json]
    end
    return response
  end

end
