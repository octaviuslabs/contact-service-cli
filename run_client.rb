require './processor'

processor = Processor.build_by_ids('./contact_list.csv')
processor.contacts.find_all!
# response = processor.contacts.push_all!
puts "DONE"
