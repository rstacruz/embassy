require 'sinatra/support/i18nsupport'

class Main
  register Sinatra::I18nSupport
  load_locales root('config/locales')
end
