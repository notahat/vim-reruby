require 'reruby/better_buffer'
require 'support/fake_buffer'

describe Reruby::BetterBuffer do

  before do
    @vim_buffer    = FakeBuffer.new("a\nb\nc\nd\n")
    @better_buffer = Reruby::BetterBuffer.new(@vim_buffer)
  end
    
  describe "[]" do
    it "returns a single line" do
      @better_buffer[2].should == "b"
    end

    it "returns a range of lines" do
      @better_buffer[2..3].should == ["b", "c"]
    end
  end

  describe "[]=" do
    it "replaces a single line" do
      @better_buffer[2] = "q"
      @vim_buffer.to_s.should == "a\nq\nc\nd\n"
    end

    it "replaces multiple lines" do
      @better_buffer[2..3] = ["q", "r", "s"]
      @vim_buffer.to_s.should == "a\nq\nr\ns\nd\n"
    end
  end

  describe "delete" do
    it "deletes a single line" do
      @better_buffer.delete(2)
      @vim_buffer.to_s.should == "a\nc\nd\n"
    end

    it "deletes multiple lines" do
      @better_buffer.delete(2..3)
      @vim_buffer.to_s.should == "a\nd\n"
    end
  end

end
