class GG::DemoApp
  
  class Custom
    
    def initialize(shape, size, color)
      @shape = shape
      @size = size
      @color = color
    end
    
    attr_reader :shape, :size, :color
    
  end
  
  class CustomWithError
    def class
      throw "Class Call Error"
    end
  end
  
  def call(env)
    case env[ 'PATH_INFO' ]
    when '/'
      response = Rack::Response.new
      response.write GG.render( 'slim/index.slim' )
      response
    when '/demo'
      log_stuff
      [ 200, { 'Content-Type' => 'text/html' }, [ "<h1>GG</h1><p>This is a demo of GG</p>"] ]
    when '/inline_demo'
      log_stuff
      [ 200, { 'Content-Type' => 'text/html' }, [ %q{
        <head>
        </head>
        <body>
          <h1>GG</h1>
          <p>This is a demo of GG</p>
          <div style="border:1px dotted silver;padding: 10px;background-color:#F0F0F0;">
            <!--gg-->
          </div>
          <p>This is a footer</p>
        </body>
      } ] ]
    when '/demo.txt'
      log_stuff
      [ 200, { 'Content-Type' => 'text/plain' }, [ "This is a demo of GG (output goes to console using awesome_print gem)"] ]
    when '/env'
      gg env
      [ 200, { 'Content-Type' => 'text/html' }, [ "<h1>GG</h1><p>This is a dump of request.env and should contain some recursion</p><!--gg-->"] ]
    when '/limit'
      hash = (1..10).inject({}) do |memo, value|
        memo[value] = (1..20).inject({}) do |memo, value|
          memo[value] = rand(1..10)
          memo
        end
        memo
      end
      gg hash
      [ 200, { 'Content-Type' => 'text/html' }, [ "<h1>GG</h1><p>This is a dump of request.env and should contain some recursion</p><!--gg-->"] ]
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
    
    custom_with_error = CustomWithError.new
    gg custom_with_error
    
    hash_with_error = {
      'a' => 'alpha',
      'custom' => CustomWithError.new
    }
    gg hash_with_error
    
    recursive_hash = { a: 'alpha', b: 'bravo' }
    recursive_array = [ :a, :b, recursive_hash ] 
    recursive_hash[ :array ] = recursive_array
    recursive_object = Object.new
    recursive_object.instance_variable_set :@hash, recursive_hash
    recursive_object.instance_variable_set :@array, recursive_array
    gg recursive_hash
    gg recursive_array
    gg recursive_object
    
    non_recursive_hash = {
      'a' => {1 => true, 2 => true},
      'b' => {1 => true, 2 => true}
    }
    gg non_recursive_hash
  end
  
end