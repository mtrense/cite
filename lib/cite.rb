
module Cite
  require 'cite/analyzer'
  require 'cite/template'
  require 'cite/tokenizer'
  
  class <<self
    
    def file(source, options = {})
      Template.new source, options.merge(file: source, line: 1)
    end
    
    def inline(source, file, *line_and_options)
      options = Hash === line_and_options.last ? line_and_options.pop : {}
      line = Integer === line_and_options.first ? line_and_options.shift : 1
      Template.new source, options.merge(file: file, line: line)
    end
    
  end
  
end
