require File.dirname(__FILE__) + '/dataset_reader'

class DecisionTree
  
  def initialize( dataset )
    @dataset = dataset
    @children = []
  end

  def choose_best_attribute
    
  end

  def calculate_information_gain( attribute )
    
  end

  def calculate_current_entropy
    partitions = @dataset.entries.group_by do |entry|
      entry[:class]
    end
    -partitions.values.inject(0.0) do |sum, partition|
      probability = partition.length.to_f / @dataset.entries.length.to_f
      entropy = probability * Math.log2(probability)
      sum += entropy
    end
  end
  
end
