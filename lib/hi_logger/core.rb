
module Kernel
  
  def gg( *args )
    #ap args
    #ap caller
    #$hi_logger << "<h1>JFKLDJSKLFSDJKL</h1>"
                                                                                                                  #ap '======================'
    #ap args.size
    stack = hi_caller
    history = {}
    # case args.size
    # when 1
      # $hi_logger << HiLogger.render( 'slim/logger.slim', { stack: stack } ) do
        # args[0].to_hi_html({})
      # end
    # else
      $hi_logger << HiLogger.render( 'slim/logger_with_multiple_variables.slim', 
        line: caller[0],
        objects: args,
        history: history,
        stack: stack
      )
    # end
  end
  
end

class Object
  
  def to_hi_html( history )
    history[ self ] = true
    if self.instance_variables.size == 0                                                        
      HiLogger.render( 'slim/object.slim',
        object: self, 
        classname: "hi-#{ self.class }", 
        history: history
      )
    else
      HiLogger.render( 'slim/object_with_instance_variables.slim', 
        object: self, 
        classname: "hi-#{ self.class }", 
        history: history
      )
    end
    # Rack::Utils.escape_html( self.inspect )
  end

end

class Numeric
  
  def to_hi_html( history )
    HiLogger.render( 'slim/object.slim', object: self, classname: "hi-Numeric" )
  end
  
end

class String
  
  def to_hi_html( history )
    HiLogger.render( 'slim/string.slim', self )
    #Tilt.new( HiLogger.path( 'string.slim' ) ).render( self )
  end
  
end

class Array
  
  def to_hi_html( history )
    return "...recursive..." if history[ self ]
    history[ self ] = true
    HiLogger.render( 'slim/array.slim', object: self, history: history )
  end
  
end

class Hash
  
  def to_hi_html( history )
    return "...recursive..." if history[ self ]
    history[ self ] = true
    HiLogger.render( 'slim/hash.slim', object: self, history: history )
  end
end