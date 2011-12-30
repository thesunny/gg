class HiLogger::RackPlugin
  
  def initialize( app )
    @app = app
    @history = []
  end
  
  MAX_HISTORY = 10
  
  attr_reader :app, :history
  
  def call( env )
    case env[ 'PATH_INFO' ]
    when '/hi_logger/history'
      render_history( env )
    else
      render_app( env )
    end
  end
  
  def render_app( env )
    #ap [ $0, *$LOADED_FEATURES ]
    env[ 'hi_logger' ] = $hi_logger = []
    result = @app.call( env )
    # Logs to the HTML page only if the response type is text/html
    if result_is_html( result )
      if $hi_logger.size > 0
        css_link = %q{<link href="/hi_logger.css" type="text/css" rel="stylesheet">}
        body = ''
        result[2].each { |s| body << s }
        add_to_history( css_link + env[ 'hi_logger' ].join )
        result[2] = [ css_link << body << env[ 'hi_logger' ].join ]
      end
    else
      # log to the console or somewhere else
    end
    result 
  end
  
  def render_history( env )
    [ 200, { 'Content-Type' => 'text/html' }, [ @history[0] ] ]
  end
  
  private
  
  def result_is_html( result )
    return true if result.respond_to?( :content_type ) && result.content_type == 'text/html'
    return true if result.is_a?( Array ) && result[1][ 'Content-Type' ] == 'text/html'    
    false
  end
  
  def add_to_history( logger )
    history.unshift logger.dup        # pushes logger on beginning of Array
    history.slice!( MAX_HISTORY ) # removes item above MAX_HISTORY if there is one
  end
  
end