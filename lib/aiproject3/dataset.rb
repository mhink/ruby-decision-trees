class Dataset

  attr_reader :attributes, :classes, :entries

  def initialize ( args ) 
    if not args[:dataset].nil? then
      #copy another Dataset
      dataset = args[:dataset]
      @attributes, @classes, @entries = dataset.attributes, dataset.classes, dataset.entries

    elsif not args[:data_filename].nil? then
      #load data from file

      args[:testing] ? quick_test_attributes_load : quick_attributes_load
      @entries = []
      
      data = File.open(args[:data_filename])
      data.each_line do |line|
        entry = { :attributes => {}, :class=>line.split( ',' ).last }
        line.split( ',' ).zip( @attributes.keys ).each do |attr, attrHash|
          entry[:attributes][attrHash] = attr if not attrHash.nil? 
          entry[:class] = attr.chomp if attrHash.nil?
        end
        @entries.push(entry)
      end
    end
    
    @attributes = args[:dataset_attributes] if not args[:dataset_attributes].nil?
    @classes    = args[:dataset_classes]    if not args[:dataset_classes].nil?
    @entries    = args[:dataset_entries]    if not args[:dataset_entries].nil?

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
