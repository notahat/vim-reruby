class FakeBuffer
  def initialize(contents)
    @lines = case contents
      when String
        contents.split("\n")
      when Array
        contents
    end
  end

  attr_reader :lines

  def [](n)
    @lines[n - 1]
  end

  def []=(n, line)
    @lines[n - 1] = line
  end

  def delete(n)
    @lines.delete_at(n - 1)
  end

  def append(n, str)
    @lines.insert(n, str)
  end

  def to_s
    @lines.join("\n") + "\n"
  end
end
