require 'reruby/better_buffer'
require 'support/fake_buffer'

module Reruby
  describe BetterBuffer do

    let(:vim_buffer) { FakeBuffer.new("a\nb\nc\nd\n") }
    subject          { BetterBuffer.new(vim_buffer) }

    describe ".[]" do
      it "returns a single line" do
        subject[2].should == "b"
      end

      it "returns a range of lines" do
        subject[2..3].should == ["b", "c"]
      end
    end

    describe ".[]=" do
      it "replaces a single line" do
        subject[2] = "q"
        vim_buffer.to_s.should == "a\nq\nc\nd\n"
      end

      it "replaces multiple lines" do
        subject[2..3] = ["q", "r", "s"]
        vim_buffer.to_s.should == "a\nq\nr\ns\nd\n"
      end
    end

    describe ".delete" do
      it "deletes a single line" do
        subject.delete(2)
        vim_buffer.to_s.should == "a\nc\nd\n"
      end

      it "deletes multiple lines" do
        subject.delete(2..3)
        vim_buffer.to_s.should == "a\nd\n"
      end
    end

    describe ".append" do
      it "appends a single line" do
        subject.append(1, "q")
        vim_buffer.to_s.should == "a\nq\nb\nc\nd\n"
      end

      it "appends multiple lines" do
        subject.append(1, ["q", "r"])
        vim_buffer.to_s.should == "a\nq\nr\nb\nc\nd\n"
      end
    end

  end
end
