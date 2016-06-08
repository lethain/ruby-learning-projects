# Implement a Spreadsheet

The goal of this project is to implement a class which
allows you treat it like a simple spreadsheet.
You should be able to access it as follows:

    s = Spreadsheet.new
    s["A1"] = "Names"
    s["B1"] = "Ages"
    s["A2"] = "Jill"
    s["B2"] = 5
    puts s["B2"] # <= 5    
    s["B2"] = 10
    puts s["B2"] # <= 10    
    s["A3"] = "Jack"
    s["B3"] = 9
    s["B4"] = "sum(B2:B3)"
    puts s["B4"] # <= 19

It should support an arbitrary number of rows and columns,
ideally without expending any space on non-existant rows,
and should support at least `sum` and `avg` in formulas.

A good solution should be able to handle chained formulas:


And a great solution should handle circular dependencies in
your formulas. The simplest example would be:

    s["A1"] = "sum(A1:A3)"

More complex would be:

    s["A1"] = "sum(A2:A3)"
    s["A3"] = "sum(B2:B3)"
    s["B3"] = s["A1"]

Another neat feature would be support for exporting your spreadsheet
to CSV.
    


