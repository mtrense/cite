
require 'ostruct'

module Cite
  
  class Analyzer
    include Enumerable
    
    def initialize(tokenizer)
      @tokenizer = tokenizer
      @history = []
    end
    
    def each(&block)
      yield :begin, nil
      @tokenizer.each do |token|
        case token
        when '{{='
          yield :output_tag_open, token
        when '{{#'
          yield :comment_tag_open, token
        when '{{'
          yield :code_tag_open, token
        when '}}'
          yield :tag_close, token
        when "\n", "\r\n", "\r"
          yield :newline, token
        else
          yield :literal, token
        end
      end
      yield :end, nil
    end
    
  end
  
end
