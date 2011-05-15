require 'hashie'
require 'yaml'

# Yaml config.
#
# == Usage
#
#   class Main
#     register Sinatra::YamlConfig
#     set :seed, yaml_config('config/seed.yml')
#   end
#
module Sinatra::YamlConfig
  def self.registered(app)
    app.set :yaml_config, lambda { |path|
      path   = File.join(root, path)
      @yamls = Hash.new
      File.exists?(path) && lambda { @yamls[path] ||= Hashie::Mash.new(YAML::load_file(path)) }
    }
  end
end
