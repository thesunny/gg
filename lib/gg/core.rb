
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
    state = GG::State.new(&block)
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
      state: state,
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
  
  def to_hi_html(state)
    return gg_render_recursive if state.exists?(self)#[self]
    if self.instance_variables.size == 0                                                        
      GG.render('slim/object.slim',
        object: self, 
        classname: "gg-#{ self.class }", 
        state: state
      )
    else
      state.add(self)#[self] = true
      GG.render('slim/object_with_instance_variables.slim', 
        object: self, 
        classname: "gg-#{ self.class }", 
        state: state
      )
    end
    # Rack::Utils.escape_html( self.inspect )
  rescue => e
    gg_render_error(e)
  end

end

class Numeric
  
  def to_hi_html(state)
    GG.render('slim/object.slim', object: self, classname: "gg-Numeric")
  rescue => e
    gg_render_error(e)
  end
  
end

class String
  
  def to_hi_html(state)
    GG.render('slim/string.slim', self)
    #Tilt.new( GG.path( 'string.slim' ) ).render( self )
  rescue => e
    gg_render_error(e)
  end
  
end

class Array
  
  def to_hi_html(state)
    return gg_render_recursive if state.exists?(self)#[self]
    state.add(self)#[self] = true
    GG.render('slim/array.slim', object: self, state: state)
  rescue => e
    gg_render_error(e)
  end
  
end

class Hash
  
  def to_hi_html(state)
    return gg_render_recursive if state.exists?(self)#self
    state.add(self) #[self] = true
    GG.render('slim/hash.slim', object: self, state: state)
  rescue => e
    gg_render_error(e)
  end

end