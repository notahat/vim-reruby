require 'reruby/method_extractor'
require 'support/fake_buffer'

describe Reruby::MethodExtractor do
  
  it "should extract a method" do
    buffer = FakeBuffer.new <<-EOF
      def a
      end

      def b
        loop do
          puts "Hello, world!"
          puts "Goodbye, cruel world."
        end
      end
    EOF

    Reruby::MethodExtractor.new(buffer).extract_method(6..7, "foo")

    buffer.to_s.should == <<-EOF
      def a
      end

      def foo
        puts "Hello, world!"
        puts "Goodbye, cruel world."
      end

      def b
        loop do
          foo
        end
      end
    EOF
  end
  
end




function! MyFunction(name) range
  ruby MyModule.my_function(a:firstline, a:lastline, a:method_name)
endfunction

command --range -nargs=1 ExtractMethod :call ExtractMethod(<f-args>)
