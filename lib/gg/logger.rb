require 'forwardable'

class GG::Logger
  
  extend Forwardable
  
  def initialize( env )
    @env = env
    @time = Time.now
    @html_array = []
    @console_array = []
    @is_empty = true
  end
  
  attr_reader :env, :time, :html_array, :console_array
  attr_accessor :response
  
  def request
    Rack::Request.new( env )
  end
  
  def response
    Rack::Response.new( env )
  end
  
  # Adds the given HTML to the HTML array storing all logging information
  def <<( html )
    @is_empty = false
    html_array << html
  end
  
  # Returns a String that represent all the HTML sent to the logger via #<<
  def html
    html_array.join
  end
  
  def empty?
    @is_empty
  end
  
end