#!/usr/bin/env rake


task :fetch_data do |t, args|
end

namespace "git" do
  task :push do
    sh "git add -A"
    sh 'git commit -m "Autocommit using rake git:push made at ' + Time.now.inspect + '"'
    sh 'git push origin master'
  end
end

namespace "test" do 
  task :run_all do
  end
end

namespace "exec" do
  task :alternate do |t, args|
    
  end
  task :default => 'car.data' do
    
  end

  directory 'data'
  file 'car.data' => 'data' do
    sh 'curl archive.ics.uci.edu/ml/machine-learning-databases/car/car.data > data/car.data'
  end
end

