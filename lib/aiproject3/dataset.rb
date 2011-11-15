class Dataset

  attr_reader :attributes, :classes, :entries

  def initialize ( dataset=nil, data_filename=nil, testing=false, dataset_attributes={}, dataset_classes=[], dataset_entries=[])
    
    if not dataset.nil? then
      #copy another Dataset
      @attributes, @classes, @entries = dataset.attributes, dataset.classes, dataset.entries

    elsif not data_filename.nil? then
      #load data from file

      testing ? quick_test_attributes_load : quick_attributes_load
      
      data = File.open.data_filename
      data.each_line do |line|
        entry = { :attributes => {}, :class=>line.split( ',' ).last }
        line.split( ',' ).zip( @attributes.keys ).each do |attr, attrHash|
          entry[:attributes][attrHash] = attr if not attrHash.nil? 
          entry[:class] = attr.chomp if attrHash.nil?
        end
        entries.push(entry)
      end
    end
    
    @attributes = dataset_attributes if not dataset_attributes.empty?
    @classes    = dataset_classes    if not dataset_classes.empty?
    @entries    = dataset_entries    if not dataset_entries.empty?

  end

  def quick_attributes_load
    @attributes = {
      :buying => ['vhigh', 'high', 'med', 'low'],
      :maint => ['vhigh', 'high', 'med', 'low'],
      :doors => ['2', '3', '4', '5more'],
      :persons => ['2', '4', 'more'],
      :lug_boot => ['small', 'med', 'big'],
      :safety => ['low', 'med', 'high']}
    @classes = ['unacc', 'acc', 'good', 'vgood']
  end 

  def quick_test_attributes_load
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
  end

  def remove_attribute( attribute )
    @entries.each do |entry|
      entry[:attributes].delete(attribute)
    end
  end
end
