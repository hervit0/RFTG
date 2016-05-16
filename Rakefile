require 'rake/testtask'

task default: 'test'

Rake::TestTask.new do |task|
  task.libs << "tests"
  task.test_files = FileList['tests/tests.rb']
end
