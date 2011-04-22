require 'reruby/better_buffer'
require 'support/fake_buffer'

describe Reruby::BetterBuffer do

  describe ".[]" do
    before do
      vim_buffer = FakeBuffer.new <<-EOF
        a
        b
        c
        d
      EOF
      @buffer = Reruby::BetterBuffer.new(vim_buffer)
    end
    
    it "returns a single line" do
      @buffer[2].should == "        b"
    end

    it "returns a range of lines" do
      @buffer[2..3].should == [
        "        b",
        "        c"
      ]
    end
  end

end
