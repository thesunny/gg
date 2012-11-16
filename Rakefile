require "bundler/gem_tasks"

# use "rake install" to create the gem

task 'demo' do
  
  require File.join( File.dirname( __FILE__ ), 'lib/hi_logger' )
  
  app = Rack::Builder.app do
    use Rack::ShowExceptions
    use Rack::Reloader, 0
    use HiLogger::RackPlugin
    # Put this here to make sure that serving files like images aren't broken
    # by the logger.
    use Rack::Static, :urls => ["/images"], :root => "public"
    #run HiLogger::DemoApp.new
    run lambda { |env|
      HiLogger::DemoApp.new.call( env )
      #gg 'Hello World'
      #[ 200, { 'Content-Type' => 'text/html' }, [ "<h1>HiLogger</h1><p>This is a demo of HiLogger</p>"] ]
    }
  end
  
  Rack::Handler::WEBrick.run( app )
  
end                                                                                         

task 'rackless' do
  
  require File.join( File.dirname( __FILE__ ), 'lib/hi_logger' )
  
  app = Rack::Builder.app do
    use Rack::ShowExceptions
    use Rack::Reloader, 0
    # Put this here to make sure that serving files like images aren't broken
    # by the logger.
    use Rack::Static, :urls => ["/images"], :root => "public"
    #run HiLogger::DemoApp.new
    run lambda { |env|
      HiLogger::DemoApp.new.call( env )
      #gg 'Hello World'
      #[ 200, { 'Content-Type' => 'text/html' }, [ "<h1>HiLogger</h1><p>This is a demo of HiLogger</p>"] ]
    }
  end
  
  Rack::Handler::WEBrick.run( app )
  
end
