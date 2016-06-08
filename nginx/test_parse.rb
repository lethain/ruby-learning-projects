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
  end

  def test_parse_simple
    np = NginxParser.new
    path = 'simple.cfg'

    cfg = np.parse_path(path)
    assert_equal(cfg.name, 'global')
    assert_equal(cfg.blocks.length, 1)
    assert_equal(cfg.blocks[0].name, 'server')

    server = cfg.blocks[0]
    assert_equal(server.blocks.length, 2)
    assert_equal(server.blocks[0].name, 'location /')
    assert_equal(server.blocks[0].attrs.length, 1)
    assert_equal(server.blocks[0].attrs[0], 'root /data/www')

    assert_equal(server.blocks[1].name, 'location /images/')
    assert_equal(server.blocks[1].attrs.length, 1)
    assert_equal(server.blocks[1].attrs[0], 'root /data')
  end

  def test_parse_complex
    np = NginxParser.new
    path = 'complex.cfg'

    cfg = np.parse_path(path)
    puts cfg
    assert_equal(cfg.name, 'global')
    assert_equal(cfg.attrs[0], "user www www")
    assert_equal(cfg.attrs[1], "worker_processes 5")
    assert_equal(cfg.blocks[0].name, "events")
    assert_equal(cfg.blocks[1].name, "http")
  end
end
