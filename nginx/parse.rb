# Parse nginx configs

TOKENS = [
  :semicolon,
  :term,
  :block_start,
  :block_end,
]


class NginxParser
  def parse_path(path)
    File.open(path, 'r') do |f|
      self.parse_stream(f)
    end
  end
  
  def parse_file(file)
    self.parse_stream(file)
  end

  def parse_string(string)
    stream = StringIO.new(string)
    self.parse_stream(stream)
  end

  def parse_stream(stream)
    block_stack = [Block.new("global")]
    line_stack = []
    
    self.tokens(stream) do |kind, token|
      case kind
      when :term
        line_stack << token
      when :semicolon
        block_stack[-1].attrs << line_stack.join(' ')
        line_stack = []
      when :block_start
        new_block = Block.new(line_stack.join(' '))
        block_stack[-1].blocks << new_block
        block_stack << new_block
        line_stack = []
      when :block_end
        block_stack.pop()
      end
    end
    block_stack[0]
  end

  def tokens(stream)
    acc = ''
    flush_acc = Proc.new do
      if acc.length > 0
        yield :term, acc
        acc = ''
      end
    end

    # TODO: this doesn't handle comments yet
    stream.each_char do |c|
      case c
      when /\s/
        flush_acc.call
      when ';'
        flush_acc.call
        yield :semicolon, c
      when '{'
        flush_acc.call
        yield :block_start, c
      when '}'
        flush_acc.call
        yield :block_end, c
      else
        acc << c
      end
    end
    flush_acc
  end
end


class Block
  attr_accessor :name, :attrs, :blocks
  
  def initialize(name)
    @name = name
    @attrs = []
    @blocks = []
  end

  def to_s
    children = (@blocks.map { |b| b.name }).join(',')
    "Block(#{@name}, attrs[#{@attrs.join(',')}], children[#{children}])"
  end    
  
end
