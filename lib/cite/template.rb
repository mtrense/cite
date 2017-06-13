# encoding: UTF-8
# Copyright 2016 Max Trense
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'pathname'
require 'thread'

module Cite
  
  class Template
    
    def initialize(source, options = {})
      if options.include?(:filename)
        @file = options.delete(:file)
        @line = options.delete(:line)
        @source = source
      else
        @file = source.to_s
        @line = 1
        @source = File.read(@file)
      end
      @stream_name = options.delete(:stream_name) || '__citeout'
      @correct_indentation = options.delete(:correct_indentation) || true
      @options = options
    end
    
    attr_reader :stream_name, :correct_indentation
    
    def assembled_template
      @assembled_template ||= begin
        template = ''
        analyzer = Analyzer.new(Tokenizer.new(@source))
        indentation = nil
        state = :text
        analyzer.each do |type, token|
          case type
          when :begin
            template << "#{stream_name} = \'\'; __indent = proc {|indentation, str| lines = str.split(/^/); if lines.empty? ; str ; else lines[1..-1] = lines[1..-1].collect {|line| indentation + line }; lines.join('') ; end }; "
          when :end
            template << "#{stream_name}; "
          when :output_tag_open then state = :output
          when :comment_tag_open then state = nil
          when :code_tag_open then state = :code
          when :tag_close then state = :text
          when :literal
            case state
            when :output
              if correct_indentation
                template << "#{stream_name} << __indent[#{indentation.inspect}, (#{token.strip}).to_s]; "
              else
                template << "#{stream_name} << (#{token.strip}).to_s; "
              end
            when :code
              template << "#{token.strip}; "
            when :text
              indentation ||= token[/\s*/]
              # puts "Setting indentation to #{indentation.inspect}"
              template << "#{stream_name} << '#{token.gsub("'") { "\\'" }}'; "
            end
          when :newline
            # puts "Resetting indentation"
            indentation = nil
            template << "#{stream_name} << #{token.inspect};#{token}"
          end
        end
        template
      end
    end
    
    def render(*args)
      begin
        locals = Hash === args.last ? args.pop : {}
        object = args.first || Object.new
        (Thread.current[:cite_templates] ||= []) << [self, object, locals]
        p = eval <<-EOF, binding, @source.to_s, -1
          proc do |#{locals.keys.join(', ')}|
            #{assembled_template}
          end
        EOF
        object.instance_exec *locals.values, &p
      ensure
        Thread.current[:cite_templates].pop
      end
    end
    
  end
  
end
