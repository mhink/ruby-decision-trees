require File.dirname(__FILE__) + '/dataset'

class DecisionTree
  
  def initialize ( dataset=nil, data_filename='', plurality_value=nil, testing=false )

    @children        = []
    @dataset         = dataset         || Dataset.new(:data_filename => data_filename, :testing=>testing)
    @plurality_value = plurality_value || determine_plurality_value
    
    generate_children if not uniform_classes? 
  end

  def determine_plurality_value
    partition_on_class.inject(0) do |best, partition|
      best = partition if partition.length > best   
    end
  end
  
  def generate_children
    partition_on_attribute(best_attribute).each do |partition|
      child_dataset = Dataset.new(
        :dataset            => @dataset,
        :dataset_entries    => partition )
      @children.push(DecisionTree.new(child_dataset, @plurality_value))
    end
  end
  
  def uniform_classes?
    @dataset.entries.inject(@dataset.entries.first[:class]) do |memo, entry|
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
  
  def calculate_entropy
    -partition_on_class.values.inject(0.0) do |sum, partition|
      probability = partition.length.to_f / entries.length.to_f
      sum += probability * Math.log2(probability)
    end
  end 
  
  def partition_on_class
    @dataset.entries.group_by do |entry|
      entry[:class]
    end
  end

  def calculate_entropy_remainder( attribute )
    partition_on_attribute(attribute).values.inject(0.0) do |sum, partition|
      ratio = partition.length.to_f / @dataset.entries.length.to_f
      partition_dataset = Dataset.
      entropy = calculate_entropy(partition)
      sum += ratio * entropy
    end
  end

end
