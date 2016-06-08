# Parse nginx configs


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
    self.words(stream) do |word|
      puts word
    end
  end

  def words(stream)
    word = ""
    stream.each_char do |c|
      if c =~ /^\s$/
        if word.length > 0
          yield word
          word = ""
        end
      else
        word << c
      end
    end
    if word.length > 0
      yield word
    end
  end

  

end
