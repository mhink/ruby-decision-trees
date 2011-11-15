require File.dirname(__FILE__) + '/spec_helper'
require 'aiproject3/dataset'
require 'aiproject3/decision_tree'

describe DecisionTree do
  before(:each) do
     spec_directory = File.dirname(__FILE__)
     @dataset = DatasetReader.new(
      (spec_directory + '/testcases/testcase.data'),
      20, true)
     @test_decision_tree = DecisionTree.new(@dataset)
  end

  it "should calculate current entropy correctly" do
    @test_decision_tree.calculate_current_entropy.should == 1
  end
  
  it "should calculate the entropy remainder correctly" do
    @test_decision_tree.calculate_entropy_remainder(:patrons).round(3).should == 0.459
  end

  it "should calculate the information gain correctly" do
    @test_decision_tree.calculate_information_gain(:patrons).round(3).should == 0.541
  end

  it "should choose the best attribute to split on" do
    @test_decision_tree.best_attribute.should == :patrons
  end

  it "should be able to detect when a partition has a uniform outcome" do
    entries = @dataset_reader.entries
    none_entries = @test_decision_tree.partition_on_attribute(:patrons, entries)['none']
    @test_decision_tree.determine_uniformity(none_entries).should_not == nil
  end
end
