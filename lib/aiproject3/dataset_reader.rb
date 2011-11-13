class DatasetReader
  def initialize ( data_filename, training_percent, testing=false )
    data = File.open(data_filename)
    
    @attrs = {}
    @classes = []
    @entries = []

    self.quick_test_attrs_load if testing
    self.quick_attrs_load if not testing

    data.each_line do |line|
      entry = {:attributes => {}, :class=>line.split(',').last}
      line.split(',').zip(@attrs.keys).each do |attr, attrHash|
        entry[:attributes][attrHash] = attr if not attrHash.nil? 
        entry[:class] = attr.chomp if attrHash.nil?
      end
      entries.push(entry)
    end
  end

  def attrs
    @attrs
  end

  def classes
    @classes
  end

  def entries
    @entries
  end

  def quick_attrs_load
    @attrs = {
      :buying => ['vhigh', 'high', 'med', 'low'],
      :maint => ['vhigh', 'high', 'med', 'low'],
      :doors => ['2', '3', '4', '5more'],
      :persons => ['2', '4', 'more'],
      :lug_boot => ['small', 'med', 'big'],
      :safety => ['low', 'med', 'high']}
    @classes = ['unacc', 'acc', 'good', 'vgood']
  end 

  def quick_test_attrs_load
    @attrs = {
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
end
