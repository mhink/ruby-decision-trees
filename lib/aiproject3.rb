require './lib/aiproject3/dataset.rb'
require './lib/aiproject3/decision_tree.rb'

test_decision_tree = DecisionTree.new :data_filename => './spec/testcases/testcase.data', :testing => true 
puts "Decision tree built!"
STDIN.gets
