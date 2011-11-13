require File.dirname(__FILE__) + '/spec_helper'
require 'aiproject3/dataset_reader'

describe DatasetReader do

  before(:each) do
    @attributes = {
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

    @classes = ['yes', 'no']

    @first_entry = {
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
    @test_reader = DatasetReader.new(
      (spec_directory + '/testcases/testcase.data'),
      20, true)
  end

  it "should read attribute names and values" do
    @test_reader.attributes.should == @attributes
  end

  it "should read the proper decision classes" do
    @test_reader.classes.should == @classes
  end

  it "should contain the correct entries" do
    @test_reader.entries.first.should == @first_entry
  end

  it "should be able to return its entries with an attribute deleted" do
    @test_reader.remove_attribute(:patrons)
    @first_entry[:attributes].delete(:patrons)
    
    @test_reader.entries.first.should == @first_entry
  end
end
