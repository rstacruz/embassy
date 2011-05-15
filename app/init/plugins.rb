require "rtopia"
require "jsfiles"
require "user_agent"
require "sinatra/yaml_config"

class Main
  helpers  Sinatra::ContentFor        # sinatra-content_for
  helpers  Sinatra::UserAgentHelpers  # agentsniff
  helpers  Rtopia

  register Sinatra::YamlConfig
end
