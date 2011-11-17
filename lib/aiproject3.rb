require './lib/aiproject3/dataset.rb'
require './lib/aiproject3/decision_tree.rb'
require 'pp'

test_decision_tree = DecisionTree.new :data_filename => './spec/testcases/testcase.data', :testing => true 
puts test_decision_tree.to_s
puts
puts
puts test_decision_tree.children['full'].inspect
puts
puts
puts test_decision_tree.children['full'].children['yes'].inspect
puts
puts
puts test_decision_tree.children['full'].children['yes'].children['thai'].inspect
puts 
puts
puts test_decision_tree.children['full'].children['yes'].children['thai'].children['yes'].inspect
STDIN.gets
