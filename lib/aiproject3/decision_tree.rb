require File.dirname(__FILE__) + '/dataset_reader'

class DecisionTree
  
  def initialize( dataset )
    @dataset = dataset
    @children = []
  end

  def calculate_current_entropy
    calculate_entropy(@dataset.entries)
  end
  
  def calculate_entropy( entries )
    -partition_on_class(entries).values.inject(0.0) do |sum, partition|
      probability = partition.length.to_f / entries.length.to_f
      sum += probability * Math.log2(probability)
    end
  end
  
  def determine_uniformity( entries )
    entries.inject(entries.first[:class]) do |memo, entry|
      memo.eql?(entry[:class]) ? memo = entry[:class] : memo = nil
    end
  end

  def partition_on_class( entries )
    entries.group_by do |entry|
      entry[:class]
    end
  end

  def partition_on_attribute( attribute, entries)
    entries.group_by do |entry|
      entry[:attributes][attribute]
    end
  end

  def calculate_entropy_remainder( attribute, entries )
    partition_on_attribute(attribute, entries ).values.inject(0.0) do |sum, partition|
      ratio = partition.length.to_f / entries.length.to_f
      entropy = calculate_entropy(partition)
      sum += ratio * entropy
    end
  end

  def calculate_information_gain( attribute, entries )
    calculate_entropy(entries) - calculate_entropy_remainder(attribute, entries)
  end
  
  def best_attribute( entries )
    @dataset.attributes.keys.inject(0.0) do |best, attribute_name|
      information_gain_current = calculate_information_gain(attribute_name, entries)  
      information_gain_best = calculate_information_gain(best, entries)
      information_gain_current > information_gain_best ? attribute_name : best
    end
  end

end
