## Assignment 3- Learning Decision Trees
####CSE 4633- Artificial Intelligence
####Submitted 11-17-2011 by Matt Hink (mrh208)
####Mississippi State University

#####REQUIREMENTS
- Developed using Ruby 1.9.2p290 on Xubuntu 11.10

#####DOWNLOADING
- Using Git
    The public readonly Git repository is available at 'git://github.com/hink1103/Learning-Decision-Trees.git'
- Download
    A .zip archive of this project is available at 'https://github.com/hink1103/Learning-Decision-Trees/zipball/master'

#####RUNNING
- Once ruby and rake are installed, run the 'rake' command to compile and run the software.
- If for whatever reason this does not work, you can manually run the program by using 'ruby ./lib/aiproject3.rb [PATH_TO_DATASET]'. This may be required to run on Windows systems.

#####NOTES ON rake
- To run the main program on the assignment dataset (car.data), run "rake exec".
- To run the main program on the dataset from the textbook, page 700, fig. 18.3, run "rake exec:test".
- To run the included test suite, run 'rake test'.

#####REFERENCES
- Ruby Language Home: http://www.ruby-lang.org/en/
- Rake Documentation: http://rake.rubyforge.org
- Ruby-Doc.org: http://www.ruby-doc.org
- Artificial Intelligence: A Modern Approach, 3rd edition (Russell,Norvig 2010)

#####NOTES
- The accuracy calculations take quite awhile- this is mainly due to Ruby being an interpreted language.  It should only take a few minutes to run the program.
