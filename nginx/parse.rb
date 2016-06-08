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
    self.tokens(stream) do |kind, token|
      puts "#{kind}: #{token}"
    end
  end

  def tokens(stream)
    acc = ''
    flush_acc = Proc.new do
      if acc.length > 0
        yield :term, acc
        acc = ''
      end
    end
    
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
