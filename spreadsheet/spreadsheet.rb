# Simple learning project for Ruby.

class Cell
  attr_accessor :val
  
  def initialize(row, col, val=nil)
    @row = row
    @col = col
    @val = val
  end

  def to_s
    "Cell(#{self.object_id},#{@row}#{@col}, #{@val})"
  end

end

class Row
  def initialize(row)
    @row = row
    @cols = {}
  end

  def get_or_create_col(col)
    if !@cols.key?(col)
      @cols[col] = Cell.new(@row, col)
    end
    @cols[col]

  end

  def [](col)
    self.get_or_create_col(col)
  end

end

class Spreadsheet
  def initialize
    @rows = {}
  end

  def []=(*args)
    row, col, val = self.extract_row_col_val(*args)
    col_obj = self.[](row, col)
    col_obj.val = val
    col_obj
  end

  def [](*args)
    row, col = self.extract_row_col(*args)
    row_obj = self.get_or_create_row(row)
    col_obj = row_obj[col]
  end

  def get_or_create_row(row)
    if !@rows.key?(row)
      @rows[row] = Row.new(row)
    end
    @rows[row]
  end

  def extract_row_col(*args)
    case args.length
    when 0
      return nil, nil
    when 1
      row, col = /([a-zA-Z]+)([0-9]+)/.match(*args[0, 1]).captures
      return row, col
    else
      return args[0], args[1]
    end
  end

  def extract_row_col_val(*args)
    case args.length
    when 2
      row, col = self.extract_row_col(*args[0, 1])
      [row, col, args[1]]
    else
      args
    end
  end

end
