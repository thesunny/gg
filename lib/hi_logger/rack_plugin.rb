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
      render_history( 0 )
    when %r{/hi_logger/history/([0-9])}
      render_history( $~[1].to_i )
    when '/hi_logger/main.css'
      [ 
        200,
        { 'Content-Type' => 'text/css' }, 
        [ File.read(File.join(File.dirname(__FILE__),'public/hi_logger.css'))]
      ]
    else
      render_app( env )
    end
  end
  
  private
  
  def render_app( env )
    #ap [ $0, *$LOADED_FEATURES ]
    env[ 'hi_logger' ] = $hi_logger = hi_logger = HiLogger::Logger.new( env )
    response = @app.call( env )
    # response = result.is_a?(Rack::Response) ? result : Rack::Response.new(result[2], result[0], result[1])
    # env[ 'hi_logger' ].response = Rack::Response.new( result )
    # env[ 'hi_logger' ].response = response
    # Logs to the HTML page only if the response type is text/html
    if !hi_logger.empty?
      if response_is_html(response)
        add_logger_to_response( response, hi_logger )
        add_logger_to_history( hi_logger )
      else
        puts
        puts '='*79
        puts env['REQUEST_URI'] || env['PATH_INFO']  
        $hi_logger.console_array.each do |item|
          puts item
        end
      end
    end
    response
  end
  
  def render_history( i )
    logger = history[i]
    body = logger
    html = HiLogger.render( 'slim/history.slim', body: body, history: history, logger: logger )
    [ 200, { 'Content-Type' => 'text/html' }, [ html ] ]
  end
  
  def response_is_html( response )
    return true if response.respond_to?( :content_type ) && response.content_type.match( %r{^text[/]html})
    return true if response.is_a?( Array ) && response[1][ 'Content-Type' ] && response[1][ 'Content-Type' ].match( %r{^text[/]html})    
    false
  end
  
  def add_logger_to_history( logger )
    history.unshift logger.dup        # pushes logger on beginning of Array
    history.slice!( MAX_HISTORY ) # removes item above MAX_HISTORY if there is one
  end
  
  def add_logger_to_response(response, hi_logger )
    css_link = %q{<link href="/hi_logger/main.css" type="text/css" rel="stylesheet">}
    body = ''
    response[2].each { |s| body << s }
    if body.sub!( /<!--\s*hi_logger\s*-->/, hi_logger.html ).nil?
      body.insert( 0, hi_logger.html )
    end
    if body.sub!( /<head>/, "<head>#{ css_link }" ).nil?
      body.insert( 0, css_link )
    end
    response[2] = [ body ]
  end
  
end