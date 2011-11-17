require './lib/aiproject3/dataset.rb'
require './lib/aiproject3/decision_tree.rb'
require 'pp'

testing = (ARGV[1]=="test")
dataset = Dataset.new :data_filename => ARGV[0], :testing => testing
#training_count = (dataset.entries.length.to_f * ARGV[2].to_i) / 100
training_count = (dataset.entries.length.to_f * 80) / 100

shuffled_entries = dataset.entries.shuffle.shuffle.shuffle #just for fun
training_entries = shuffled_entries.take(training_count)
testing_entries  = shuffled_entries - training_entries

puts shuffled_entries.to_s
puts
puts training_entries.to_s
puts
puts testing_entries.to_s
puts

testing_dataset = Dataset.new(
                :dataset_attributes => dataset.attributes,
                :dataset_classes    => dataset.classes,
                :dataset_entries    => testing_entries )

training_dataset = Dataset.new(
                :dataset_attributes => dataset.attributes,
                :dataset_classes    => dataset.classes,
                :dataset_entries    => training_entries )

test_decision_tree = DecisionTree.new :dataset => training_dataset, :testing => testing

result_total = {true => 0, false => 0}

testing_dataset.entries.each do |entry|
  result = test_decision_tree.matches_tree?(entry)
  result_total[result] += 1
end

puts "Results: "
percent_accurate = (result_total[true]).to_f / (result_total[true] + result_total[false]).to_f
puts result_total[true].to_s + " accurate predictions"
puts result_total[false].to_s + " inaccurate predictions"
puts "Accuracy: " + percent_accurate.to_s
