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
    when '/'
      response = Rack::Response.new
      response.write HiLogger.render( 'slim/index.slim' )
      response
    when '/demo'
      log_stuff
      [ 200, { 'Content-Type' => 'text/html' }, [ "<h1>HiLogger</h1><p>This is a demo of HiLogger</p>"] ]
    when '/inline_demo'
      log_stuff
      [ 200, { 'Content-Type' => 'text/html' }, [ %q{
        <head>
        </head>
        <body>
          <h1>HiLogger</h1>
          <p>This is a demo of HiLogger</p>
          <div style="border:1px dotted silver;padding: 10px;background-color:#F0F0F0;">
            <!--hi_logger-->
          </div>
          <p>This is a footer</p>
        </body>
      } ] ]
    when '/demo.txt'
      log_stuff
      [ 200, { 'Content-Type' => 'text/plain' }, [ "This is a demo of HiLogger (output goes to console using awesome_print gem)"] ]
    else
      [ 404, { 'Content-Type' => 'text/html' }, [ "<h1>Page Not Found</h1>" ] ]
    end
  end
  
  def log_stuff
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
    recursive_hash = { a: 'alpha', b: 'bravo' }
    recursive_array = [ :a, :b, recursive_hash ] 
    recursive_hash[ :array ] = recursive_array
    gg recursive_hash
    gg recursive_array
  end
  
end