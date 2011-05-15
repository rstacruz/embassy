require_relative 'plugins'

class Main
  set :seed, yaml_config('config/defaults/seed.yml')
end
