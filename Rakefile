require "bundler/gem_tasks"

# use "rake install" to create the gem

task 'demo' do
  
  require File.join( File.dirname( __FILE__ ), 'lib/gg' )
  
  app = Rack::Builder.app do
    use Rack::ShowExceptions
    use Rack::Reloader, 0
    use GG
    # Put this here to make sure that serving files like images aren't broken
    # by the logger.
    use Rack::Static, :urls => ["/images"], :root => "public"
    #run HiLogger::DemoApp.new
    run lambda { |env|
      GG::DemoApp.new.call( env )
      #gg 'Hello World'
      #[ 200, { 'Content-Type' => 'text/html' }, [ "<h1>HiLogger</h1><p>This is a demo of HiLogger</p>"] ]
    }
  end
  
  Rack::Handler::WEBrick.run( app )
  
end                                                                                         


# use this for testing to see that if you don't have the rack plugin installed,
# that it will display useful error messages to the console.
task 'rackless' do
  
  require File.join( File.dirname( __FILE__ ), 'lib/gg' )
  
  app = Rack::Builder.app do
    use Rack::ShowExceptions
    use Rack::Reloader, 0
    # Put this here to make sure that serving files like images aren't broken
    # by the logger.
    use Rack::Static, :urls => ["/images"], :root => "public"
    #run HiLogger::DemoApp.new
    run lambda { |env|
      GG::DemoApp.new.call( env )
    }
  end
  
  Rack::Handler::WEBrick.run( app )
  
end
