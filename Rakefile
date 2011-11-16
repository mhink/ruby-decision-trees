#!/usr/bin/env rake

task :exec => "exec:default" do
end

namespace "git" do
  task :push do
    sh "git add -A"
    sh 'git commit -m "Autocommit using rake git:push made at ' + Time.now.inspect + '"'
    sh 'git push origin master'
  end
end

namespace "exec" do
  task :alternate do |t, args|
    
  end
  task :default => 'car.data' do
    sh 'ruby ./lib/aiproject3.rb /data/car.data'
  end
  task :test_data do
    sh 'ruby ./lib/aiproject3.rb /spec/testcases/testcase.data'
  end

  directory 'data'
  file 'car.data' => 'data' do
    sh 'curl archive.ics.uci.edu/ml/machine-learning-databases/car/car.data > data/car.data'
  end
end

task :test do
  sh 'rspec spec'
end
