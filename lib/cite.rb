
module Cite
  require 'cite/analyzer'
  require 'cite/template'
  require 'cite/tokenizer'
  
  class <<self
    
    def Template(source, options = {})
      Template.new source, options
    end
    
  end
  
end
