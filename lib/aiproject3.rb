require './lib/aiproject3/dataset_reader.rb'
require './lib/aiproject3/decision_tree.rb'

data = File.open(ARGV[0])

attributes = {
      :alternate => ['yes', 'no'], 
      :bar => ['yes', 'no'], 
      :weekend => ['yes', 'no'], 
      :hungry => ['yes', 'no'], 
      :patrons => ['none', 'some', 'full'], 
      :price => ['$', '$$', '$$$', '$$$$'], 
      :raining => ['yes', 'no'], 
      :reservation => ['yes', 'no'], 
      :type => ['french', 'italian', 'thai', 'burger'], 
      :wait_estimate => ['10', '30', '60', 'more']}
classes = ['yes', 'no']
entries = []

data.each_line do |line|
  entry = {:attributes => {}, :class=>line.split(',').last}
  line.split(',').zip(@attributes.keys).each do |attr, attrHash|
    entry[:attributes][attrHash] = attr if not attrHash.nil?
    entry[:class] = attr.chomp if attrHash.nil?
  end
  entries.push(entry)
end


