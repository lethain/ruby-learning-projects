# Test parse.rb
require "./parse.rb"
require "test/unit"

class TestParse < Test::Unit::TestCase
  def test_loading_files
    np = NginxParser.new
    path = 'simple.cfg'
    np.parse_path(path)
    File.open(path, 'r') do |f|
      np.parse_file(f)
    end
    np.parse_string(File.read(path))
    # assert_equal('a', 2)
  end
end
