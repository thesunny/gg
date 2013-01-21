# Represents one item in the callstack returned by the Kernel#caller method.
# This is a better representation because it parses out the #dir, #path, #code
# and other pieces of the callstack item.

class GG::StackLine
    
  # Takes a string from the array of strings returned from Ruby's method
  # Kernel#caller.
  def initialize( s )
    matchdata = /^(.*)[:]([0-9]+)(?:[:]in `(.*)')?$/.match( s )
    # If the line in caller can be parsed, then set the correct instance vars
    if matchdata
      @path = File.expand_path( matchdata[1] )
      @line_number = matchdata[2].to_i
      @method_name = matchdata[3] ? matchdata[3].to_sym : nil
    # If there is no proper match, we just set all the values to nil.
    # Technically this isn't required but it makes for clearer intent here. :)
    else
      @path = nil
      @line = nil
      @method_name = nil
    end
    @value = s
  end
  
  attr_reader :path, :method_name, :value, :line_number
  
  def code_lines
    @code_lines ||= File.readlines( path )
  end
  
  def code_line
    code_lines[ line_number-1 ]
  end
  
  # Returns the directory of the StackLine
  def dir
    File.dirname( path )
  end
  
  # Joins the directory of the stakk item with the given subpath
  def join( subpath )
    File.join( dir, subpath )
  end
  
  alias :to_s :value
  
end