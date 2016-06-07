require "./spreadsheet.rb"
require "test/unit"

class TestSpreadsheet < Test::Unit::TestCase
  def test_extract_row_col
    s = Spreadsheet.new
    assert_equal(["A", "1"], s.extract_row_col("A1"))
    assert_equal(["A", "1"], s.extract_row_col("A", "1"))
    assert_equal(["A", "2"], s.extract_row_col("A", "2"))

    assert_equal(["A", "2", "1"], s.extract_row_col_val("A2", "1"))
    assert_equal(["A", "2", "1"], s.extract_row_col_val("A", "2", "1"))

  end


  def test_spreadsheet
    s = Spreadsheet.new
    x = s["A2"]
    assert_equal(x.class, Cell)
    assert_equal(x.object_id, s["A2"].object_id)
    assert_equal(x.val, nil)
    x.val = 10
    assert_equal(x.val, 10)
    assert_equal(s["A2"].val, 10)
    s["A2"] = 20
    assert_equal(x.val, 20)
    assert_equal(s["A2"].val, 20)
  end
end
