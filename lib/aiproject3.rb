require './lib/aiproject3/dataset.rb'
require './lib/aiproject3/decision_tree.rb'
require 'pp'

testing = (ARGV[1]=="test")
dataset = Dataset.new :data_filename => ARGV[0], :testing => testing

#shorthand for each training count

training_percents = {"20%" => 20, "40%" => 40, "60%" => 60, "80%" => 80}

all_percents = training_percents.values.collect do |training_percent|
  (1..10).to_a.inject do |average, trials|
    training_count = (dataset.entries.length * training_percent) / 100
    
    shuffled_entries = dataset.entries.shuffle.shuffle.shuffle #just for fun
    training_entries = shuffled_entries.take(training_count)
    testing_entries  = shuffled_entries - training_entries
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
      if result then print '+' else print '.' end
      result_total[result] += 1
    end

    puts
    
    percent_accurate = result_total[true].to_f / testing_dataset.entries.length.to_f
    average = ((average*(trials-1)) + percent_accurate) / trials
  end
end

puts

final_results = Hash[training_percents.keys.zip(all_percents)]
final_results.each do |label, percentage|
  puts label + " of data as training set- " + (percentage * 100).round(2).to_s + "% accurate."
end
