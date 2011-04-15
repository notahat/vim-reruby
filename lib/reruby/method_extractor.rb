require 'reruby/better_buffer'

module Reruby
  class MethodExtractor

    def initialize(buffer)
      @buffer = BetterBuffer.new(buffer)
    end

    def extract_method(line_range, method_name) 
      extracted_lines = @buffer[line_range]

      # Replace the extracted lines with a call to the new method.
      @buffer[line_range] = indent(measure_indent(extracted_lines.first), method_name)

      # Find the start of the current method.
      start_of_method = grep_backwards_from(line_range.first - 1, /^\s*def/)

      # Build up the new method.
      new_method = []
      new_method << "def #{method_name}"
      new_method += reindent(2, extracted_lines)
      new_method << "end"
      new_method << ""

      # Insert the new method before the current method.
      @buffer.append(start_of_method - 1, indent(measure_indent(@buffer[start_of_method]), new_method))
    end

  private

    def grep_backwards_from(line, regexp)
      until @buffer[line] =~ regexp
        line -= 1
      end
      line
    end

    def measure_indent(s)
      s.match(/^\s*/).to_s.length
    end

    def indent(depth, lines)
      case lines
        when Array
          lines.map {|line| indent(depth, line) }
        else
          indent = " "*depth
          lines == "" ? "" : "#{indent}#{lines}"
      end
    end

    def unindent(depth, lines)
      case lines
        when Array
          lines.map {|line| unindent(depth, line) }
        else
          indent = " "*depth
          lines.sub(/^#{indent}/, "")
      end
    end
      
    def reindent(new_depth, lines)
      original_depth = measure_indent(lines.first)
      indent(new_depth, unindent(original_depth, lines))
    end

  end
end

