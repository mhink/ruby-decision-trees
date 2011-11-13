require File.dirname(__FILE__) + '/spec_helper'
require 'aiproject3/dataset_reader'
require 'aiproject3/decision_tree'

describe DecisionTree do
  before(:each) do
     spec_directory = File.dirname(__FILE__)
     @dataset_reader = DatasetReader.new(
      (spec_directory + '/testcases/testcase.data'),
      20, true)
     @test_decision_tree = DecisionTree.new(@dataset_reader)
  end

  it "should calculate current entropy correctly" do
    @test_decision_tree.calculate_current_entropy.should == 1
  end
  
  it "should calculate the entropy remainder correctly" do
    @test_decision_tree.calculate_entropy_remainder(:patrons, @dataset_reader.entries ).round(3).should == 0.459
  end

  it "should calculate the information gain correctly" do
    @test_decision_tree.calculate_information_gain(:patrons, @dataset_reader.entries).round(3).should == 0.541
  end
end
