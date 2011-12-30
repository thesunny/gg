require 'rack'
require 'awesome_print'
require 'slim'
require 'hi_caller'
require 'hi_logger/version'
require 'hi_logger/rack_plugin'
require 'hi_logger/demo_app'
require 'hi_logger/core'
require 'hi_logger/logger'

module HiLogger
  
  def self.root
    @root ||= File.join( File.dirname( __FILE__ ), 'hi_logger' )
  end
  
  def self.path( subpath )
    File.join( root, subpath )
  end
  
  def self.render( subpath, scope=nil, &block )
    Tilt.new( HiLogger.path( subpath ) ).render( scope, &block )
    # if scope
      # Tilt.new( HiLogger.path( subpath ) ).render( scope, &block )
    # elsif block_given?
      # Tilt.new( HiLogger.path( subpath ) ).render( &block )
    # else
      # raise ArgumentError, "Must provide one of scope or block"
    # end
  end
  
  # Your code goes here...
end
              