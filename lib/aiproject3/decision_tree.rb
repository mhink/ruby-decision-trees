require File.dirname(__FILE__) + '/dataset'
require 'pp'

class DecisionTree

  attr_reader :children, :dataset
  
  def initialize ( args ) 
    @children        = {}
    @dataset         = args[:dataset] || Dataset.new(
                        :data_filename => args[:data_filename], 
                        :testing       => args[:testing])
    @plurality_value = args[:plurality_value] || determine_plurality_value
    @parent_id = args[:parent_id]

    @parent_id = "roottree" if @parent_id.nil?

    generate_children 
    
    @children.each do |child_val, child|
      print @parent_id.to_s + " (" + best_attribute.to_s + ") "
      if child.is_a?(DecisionTree) then puts child_val + " => " + child.object_id.to_s 
      else puts child_val.to_s + " => " + child.to_s
      end
    end
  end

  def matches_tree?( entry )
    child = @children[entry[:attributes][best_attribute]]
    if child.is_a?(DecisionTree) then
      return child.matches_tree?(entry)
    else
      return child.eql?(entry[:class])
    end
  end

  def determine_plurality_value
    partition_on_class.max do |a, b| 
      a[1].length <=> b[1].length
    end[0]
  end

  def generate_children
    current_best_attribute = best_attribute

    @dataset.attributes[current_best_attribute].each do |attr_value|
      children[attr_value] = @plurality_value
    end
    
    partition_on_attribute(current_best_attribute).each do |best_attribute_value, entries|
      child_entries = []

      entries.each do |entry|
        entry_attributes = {}
        entry[:attributes].each do |attribute, value|
          entry_attributes[attribute] = value.clone
        end
        child_entries.push({:attributes => entry_attributes, :class=>entry[:class].clone})
      end

      child_dataset = Dataset.new(
        :dataset_classes    => @dataset.classes.clone,
        :dataset_attributes => @dataset.attributes.clone,
        :dataset_entries    => child_entries )

      child_dataset.remove_attribute(current_best_attribute)
      
      if not child_dataset.uniform_class.nil? then
        children[best_attribute_value] = child_dataset.uniform_class
      else
        children[best_attribute_value] = DecisionTree.new(
          :dataset => child_dataset,
          :plurality_value => @plurality_value,
          :parent_id => self.object_id )
      end
    end
  end
  
  def uniform_classes?( entries = @dataset.entries)
    entries.inject(entries.first[:class]) do |memo, entry|
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
end
