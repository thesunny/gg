
module Kernel
  
  def gg_caller(start=1)
    # we add another +1 because we have to remove the current #hi_caller call
    # from the stack.
    GG::Stack.new(caller(start+1))
  end

  def gg(*args)
    #ap args
    #ap caller
    #$gg << "<h1>JFKLDJSKLFSDJKL</h1>"
                                                                                                                  #ap '======================'
    #ap args.size
    stack = gg_caller
    history = {}
    # case args.size
    # when 1
      # $gg << GG.render( 'slim/logger.slim', { stack: stack } ) do
        # args[0].to_hi_html({})
      # end
    # else
    
    # RENDER HTML
    $gg << GG.render( 'slim/logger_with_multiple_variables.slim', 
      line: caller[0],
      objects: args,
      history: history,
      stack: stack
    )
    
    # RENDER CONSOLE
    $gg.console_array << <<-EOF
#{'-'*79}
#{caller[0]}
#{stack[0].code_line.strip}
#{'.'*79}
#{args.ai({})}
    EOF
    # end
  end
  
end

class Object
  
  def to_hi_html(history)
    history[self] = true
    if self.instance_variables.size == 0                                                        
      GG.render('slim/object.slim',
        object: self, 
        classname: "hi-#{ self.class }", 
        history: history
      )
    else
      GG.render('slim/object_with_instance_variables.slim', 
        object: self, 
        classname: "hi-#{ self.class }", 
        history: history
      )
    end
    # Rack::Utils.escape_html( self.inspect )
  end

end

class Numeric
  
  def to_hi_html(history)
    GG.render('slim/object.slim', object: self, classname: "hi-Numeric")
  end
  
end

class String
  
  def to_hi_html(history)
    GG.render('slim/string.slim', self)
    #Tilt.new( GG.path( 'string.slim' ) ).render( self )
  end
  
end

class Array
  
  def to_hi_html(history)
    return "...recursive..." if history[self]
    history[self] = true
    GG.render('slim/array.slim', object: self, history: history)
  end
  
end

class Hash
  
  def to_hi_html(history)
    return "...recursive..." if history[self]
    history[self] = true
    GG.render('slim/hash.slim', object: self, history: history)
  end
end