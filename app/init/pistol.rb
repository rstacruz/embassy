# Pistol auto-reloads your app in development mode.
class Main
  configure :development do
    require 'pistol'
    use(Pistol, Dir[root("./{lib,app}/**/*.rb")] + Dir[root("./config/**/*")]) { reset! and load(root('init.rb')) }
  end
end
