require './lib/aiproject3/dataset.rb'
require './lib/aiproject3/decision_tree.rb'
require 'pp'

testing = (ARGV[1]=="test")
test_decision_tree = DecisionTree.new :data_filename => ARGV[0], :testing => testing
STDIN.gets
