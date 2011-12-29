class HiLogger::DemoApp
  
  class Custom
    
    def initialize( shape, size, color )
      @shape = shape
      @size = size
      @color = color
    end
    
    attr_reader :shape, :size, :color
    
  end
  
  def call( env )
    case env[ 'PATH_INFO' ]
    when '/hi_logger.css'
      [ 200, { 'Content-Type' => 'text/css' }, [ File.read(File.join(File.dirname(__FILE__),'public/hi_logger.css'))] ]
    when '/'
      response = Rack::Response.new
      response.write HiLogger.render( 'slim/index.slim' )
      response
    when '/demo'
      help = "this is what I mean by help"
      gg Object.new
      gg 123
      gg 12.5
      gg Object.new, true, :symbol, 'String'
      gg true
      gg false
      gg nil
      gg /^http[:]/
      gg "Hello World <Escaped>"
      gg [ 1, "two", :three, [ 4, 5, 6 ] ]
      hash = {
        make: 'Lamborghini', 
        model: 'Aventador', 
        color: 'yellow', 
        tags: [ 'car', 'exotic' ],
        wheels: {
          front: 22,
          rear: 24
        }
      }
      gg hash
      custom = Custom.new( 'cube', [ 5, 3 ], 'yellow' )
      gg custom
      [ 200, { 'Content-Type' => 'text/html' }, [ "<h1>HiLogger</h1><p>This is a demo of HiLogger</p>"] ]
    when '/demo.txt'
      gg 123
      gg( make: 'Ferrari', model: '458 Spider' )
      [ 200, { 'Content-Type' => 'text/plain' }, [ "This is a demo of HiLogger (output goes to console using awesome_print gem)"] ]
    else
      [ 404, { 'Content-Type' => 'text/html' }, [ "<h1>Page Not Found</h1>" ] ]
    end
  end
  
end