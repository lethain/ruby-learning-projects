# Simple learning project for Ruby.

FORMULAS = ['sum', 'avg']

class CellRange
  include Enumerable
  
  def initialize(range)
    @srow, @scol, @erow, @ecol = /([A-Za-z]+)([0-9]+):([A-Za-z]+)([0-9]+)/.match(range).captures
  end

  def each
    (@srow..@erow).each do |row|
      (@scol..@ecol).each do |col|
        yield "#{row}#{col}"
      end
    end
  end
  
end

class Cell
  def initialize(row, col, val=nil)
    @row = row
    @col = col
    @val = val
  end

  def val(id=nil)  
    if self.formula?
      puts "is formula: #{@val}, id: #{id}"
      if id == self.object_id
        raise "entered circular loop of evaluation"
      elsif id == nil
        id = self.object_id
      end
      self.eval_formula(id)
    else
      @val
    end
  end

  def eval_formula(id)
    cells = []
    "not implemented"
  end

  def formula?
    if @val.class == String
      FORMULAS.each do |f|
        if @val.downcase.include?(f)
          return true
        end
      end
    end
    false
  end

  def val=(val)
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
