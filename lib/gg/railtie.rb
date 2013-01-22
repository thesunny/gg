class GG
  class Railtie < Rails::Railtie
    initializer "gg.insert_middleware" do |app|
      app.config.middleware.use "GG"
    end
  end
end