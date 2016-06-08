require "./spreadsheet.rb"
require "test/unit"

class TestSpreadsheet < Test::Unit::TestCase
  def test_cell_range
    assert_equal(CellRange.new("A1:A3").to_a, ["A1", "A2", "A3"])
    assert_equal(CellRange.new("A1:C1").to_a, ["A1", "B1", "C1"])
    assert_equal(CellRange.new("A1:B2").to_a, ["A1", "A2", "B1", "B2"])
  end

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

  def test_sum
    s = Spreadsheet.new
    s["A1"] = 5
    s["A2"] = 10
    s["A3"] = 11
    s["A12"] = 4
    s["B1"] = "sum(A1:A100)"
    assert_equal(s["B1"].val, 30)
  end

  def test_avg
    s = Spreadsheet.new
    s["A1"] = 5
    s["A2"] = 5
    s["A3"] = 15
    s["A12"] = 15
    s["B1"] = "avg(A1:A100)"
    assert_equal(s["B1"].val, 10)
  end


end
