
module Cite
  
  class Tokenizer
    include Enumerable
    
    def initialize(source)
      @source = source
    end
    
    def each
      @source.split(%r'({{\#|{{\?|{{=|{{|}}|\r\n|\n|\r)').each do |token|
        yield token
      end
    end
    
  end
  
end
