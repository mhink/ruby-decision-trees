require File.dirname(__FILE__) + '/dataset'
require 'pp'

class DecisionTree

  attr_reader :children
  
  def initialize ( args ) 
    puts "(#{args[:parent_id]} => (#{args[:parent_attr]} => #{args[:my_value]})) : #{self.object_id.to_s}"
    #dataset 
    #data_filename 
    #plurality_value 
    #testing 
   
    @children        = []
    @dataset         = args[:dataset] || Dataset.new(
                        :data_filename => args[:data_filename], 
                        :testing       => args[:testing])
    @plurality_value = args[:plurality_value] || determine_plurality_value

    
    #generate_children if not uniform_classes? 
  end

  def determine_plurality_value
    partition_on_class.inject(0) do |best, partition|
      best = partition.length if partition.length > best   
    end
  end
  
  def generate_children
    current_best_attribute = best_attribute
    partition_on_attribute(current_best_attribute).values.each do |partition|
      my_value = partition.first[:attributes][current_best_attribute]
      remove_attribute(current_best_attribute, partition)
      child_attributes = @dataset.attributes
      child_attributes.delete(current_best_attribute)
      child_dataset = Dataset.new(
        :dataset_classes    => @dataset.classes,
        :dataset_attributes => child_attributes,
        :dataset_entries    => partition )
      @children.push(
        DecisionTree.new(
          :dataset => child_dataset, 
          :plurality_value => @plurality_value,
          :parent_id => self.object_id.to_s,
          :parent_attr => current_best_attribute,
          :my_value => my_value) )
    end
  end
  
  def uniform_classes?
    @dataset.entries.inject(@dataset.entries.first[:class]) do |memo, entry|
      puts "memo: #{memo.to_s}"
      puts "entry[:class] : #{entry[:class].to_s}"
      memo.eql?(entry[:class]) ? memo = entry[:class] : memo = nil
    end
  end
  
  def partition_on_attribute( attribute )
    @dataset.entries.group_by do |entry|
      entry[:attributes][attribute]
    end
  end

  def best_attribute
    @dataset.attributes.keys.inject do |best, attribute_name|
      information_gain_current = calculate_information_gain(attribute_name)  
      information_gain_best = calculate_information_gain(best)
      information_gain_current > information_gain_best ? attribute_name : best
    end
  end

  def calculate_information_gain( attribute )
    puts "Calculate information gain " + attribute.to_s
    puts "  " + calculate_entropy.to_s
    puts "  " + calculate_entropy_remainder(attribute).to_s
    calculate_entropy - calculate_entropy_remainder(attribute)
  end
  
  def calculate_entropy( entries = @dataset.entries )
    -partition_on_class( entries ).values.inject(0.0) do |sum, partition|
      probability = partition.length.to_f / entries.length.to_f
      sum += probability * Math.log2(probability)
    end
  end 
  
  def partition_on_class( entries = @dataset.entries )
    entries.group_by do |entry|
      entry[:class]
    end
  end

  def calculate_entropy_remainder( attribute )
    partition_on_attribute(attribute).values.inject(0.0) do |sum, partition|
      ratio = partition.length.to_f / @dataset.entries.length.to_f
      entropy = calculate_entropy( partition )
      sum += ratio * entropy
    end
  end
  
  def remove_attribute(attribute, partition)
    partition.each do |entry|
      entry[:attributes].delete(attribute)
    end
  end
end
