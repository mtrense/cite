require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))

require 'cite'

task :default => :spec

task :examples => [:example_empty, :example_test1, :example_instance1] do
end
namespace :example do
  
  task :empty do
    t1 = Cite.file('examples/empty1.cite')
    puts " === Empty 1 ==="
    puts t1.assembled_template
    puts " ========================================"
    puts t1.render
    t2 = Cite.file('examples/empty2.cite')
    puts " === Empty 2 ==="
    puts t2.assembled_template
    puts " ========================================"
    puts t2.render
  end

  task :test1 do
    t = Cite.file('examples/test1.cite')
    puts " === Test 1 ==="
    puts t.render(name: 'Fred', paragraph_name: 'Paragraph', paragraph: "abc\ndef")
    puts " ========================================"
    puts t.assembled_template
  end

  task :instance1 do
    t = Cite.file('examples/instance1.cite')
    obj = Object.new
    obj.instance_variable_set :@name, 'Barney'
    def obj.test_method(arg)
      "Output of test method (incl. arg #{arg.inspect})"
    end
    puts " === Instance 1 ==="
    puts t.render(obj)
    puts " ========================================"
    puts t.assembled_template
  end
  
end
