require 'rack'
require 'awesome_print'
require 'slim'
require 'gg/version'
require 'gg/rack_plugin'
require 'gg/demo_app'
require 'gg/core'
require 'gg/logger'
require 'gg/history'
require 'gg/stack'
require 'gg/stack_line'

# For automatic integration into Rails
require "gg/railtie" if defined? Rails

class GG
  
  def self.root
    @root ||= File.join( File.dirname( __FILE__ ), 'gg' )
  end
  
  def self.path( subpath )
    File.join( root, subpath )
  end
  
  def self.render( subpath, scope=nil, &block )
    Tilt.new( GG.path( subpath ) ).render( scope, &block )
    # if scope
      # Tilt.new( GG.path( subpath ) ).render( scope, &block )
    # elsif block_given?
      # Tilt.new( GG.path( subpath ) ).render( &block )
    # else
      # raise ArgumentError, "Must provide one of scope or block"
    # end
  end
  
  # Your code goes here...
end
              