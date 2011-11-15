require File.dirname(__FILE__) + '/spec_helper'
require 'aiproject3/dataset'

describe Dataset do

  before(:each) do
    @test_attributes = {
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

    @test_classes = ['yes', 'no']

    @test_entry_first = {
      :attributes => {
        :alternate => 'yes', 
        :bar => 'no', 
        :weekend => 'no', 
        :hungry => 'yes', 
        :patrons => 'some', 
        :price=>'$$$', 
        :raining => 'no', 
        :reservation => 'yes', 
        :type => 'french', 
        :wait_estimate => '10'}, 
      :class => 'yes'}

    spec_directory = File.dirname(__FILE__)
    @test_dataset = Dataset.new(
      (spec_directory + '/testcases/testcase.data'),
      20, true)
  end

  it "should read attribute names and values" do
    @test_dataset.attributes.should == @test_attributes
  end

  it "should read the proper decision classes" do
    @test_dataset.classes.should == @test_classes
  end

  it "should contain the correct entries" do
    @test_dataset.entries.first.should == @test_entry_first
  end

  it "should be able to return its entries with an attribute deleted" do
    @test_dataset.remove_attribute(:patrons)
    @test_entry_first[:attributes].delete(:patrons)
    
    @test_dataset.entries.first.should == @test_entry_first
  end
end
