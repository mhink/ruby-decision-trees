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
end
