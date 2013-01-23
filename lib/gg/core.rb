
module Kernel
  
  def gg_caller(start=1)
    # we add another +1 because we have to remove the current #hi_caller call
    # from the stack.
    GG::Stack.new(caller(start+1))
  end

  def gg(*args, &block)
    #ap args
    #ap caller
    #$gg << "<h1>JFKLDJSKLFSDJKL</h1>"
    #ap '======================'
    #ap args.size
    stack = gg_caller
    history = GG::State.new
    history.instance_eval(&block) if block
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
    begin
      $gg.console_array << '-'*79
      $gg.console_array << caller[0]
      $gg.console_array << stack[0].code_line.strip
      $gg.console_array << '-'*79
      $gg.console_array << args.ai({})
    rescue => e
      $gg.console_array << e.inspect
    end
  end
  
  def gg_render_error(e)
    "<span class=\"gg-error\">error in gg: #{Rack::Utils.escape_html(e.inspect)}</span>"
  end
  
  def gg_render_recursive
    "<span class=\"gg-recursive\">...recursive...</span>"
  end
  
end

class Object
  
  def to_hi_html(history)
    return gg_render_recursive if history.exists?(self)#[self]
    if self.instance_variables.size == 0                                                        
      GG.render('slim/object.slim',
        object: self, 
        classname: "hi-#{ self.class }", 
        history: history
      )
    else
      history.add(self)#[self] = true
      GG.render('slim/object_with_instance_variables.slim', 
        object: self, 
        classname: "hi-#{ self.class }", 
        history: history
      )
    end
    # Rack::Utils.escape_html( self.inspect )
  rescue => e
    gg_render_error(e)
  end

end

class Numeric
  
  def to_hi_html(history)
    GG.render('slim/object.slim', object: self, classname: "hi-Numeric")
  rescue => e
    gg_render_error(e)
  end
  
end

class String
  
  def to_hi_html(history)
    GG.render('slim/string.slim', self)
    #Tilt.new( GG.path( 'string.slim' ) ).render( self )
  rescue => e
    gg_render_error(e)
  end
  
end

class Array
  
  def to_hi_html(history)
    return gg_render_recursive if history.exists?(self)#[self]
    history.add(self)#[self] = true
    GG.render('slim/array.slim', object: self, history: history)
  rescue => e
    gg_render_error(e)
  end
  
end

class Hash
  
  def to_hi_html(history)
    return gg_render_recursive if history.exists?(self)#self
    history.add(self) #[self] = true
    GG.render('slim/hash.slim', object: self, history: history)
  rescue => e
    gg_render_error(e)
  end

end