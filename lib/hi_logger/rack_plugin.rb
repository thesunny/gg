class HiLogger::RackPlugin
  
  def initialize( app )
    @app = app
  end
  
  def call( env )
    #ap [ $0, *$LOADED_FEATURES ]
    env[ 'hi_logger' ] = $hi_logger = []
    result = @app.call( env )
    # Logs to the HTML page only if the response type is text/html
    if result[1][ 'Content-Type' ] == 'text/html'
      if $hi_logger.size > 0
        body = [ %q{<link href="/hi_logger.css" type="text/css" rel="stylesheet">} ]
        result[2].each { |s| body << s }
        result[2] = body.concat( env[ 'hi_logger' ] )
      end
    else
      # log to the console or somewhere else
    end
    result 
  end
  
end