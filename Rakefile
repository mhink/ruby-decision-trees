#!/usr/bin/env rake

task :default => :exec do
end

task :exec => 'car.data' do
  sh "ruby lib/AIProject3.rb"
end

directory 'data'
file 'car.data' => 'data' do
  sh 'curl archive.ics.uci.edu/ml/machine-learning-databases/car/car.data > data/car.data'
end
