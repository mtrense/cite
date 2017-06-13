# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rake/file_list'

Gem::Specification.new do |spec|
  spec.name          = 'cite'
  spec.version       = File.read(File.expand_path('../VERSION', __FILE__)).strip
  spec.authors       = ['Max Trense']
  spec.email         = ['max.trense@namics.com']

  spec.summary       = %q{Correctly indenting template engine}
  spec.homepage      = 'https://www.trense.info/projects'

  spec.files         = Rake::FileList[%W'lib/**/*.rb example/** exe/* spec/**/*_spec.rb VERSION *.gemspec *.md']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.6'
end
