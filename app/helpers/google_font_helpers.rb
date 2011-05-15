class Main
  # Usage:
  #
  #   <%= google_font "League Script" %>
  #   <%= google_font "PT Sans", :regular, :bold %>
  #
  module GoogleFontHelpers
    URL = "<link href='http://fonts.googleapis.com/css?family=%s' rel='stylesheet' type='text/css'>"

    def google_font(name, *variations)
      spec = CGI.escape(name)
      spec = "#{spec}:#{variations.join(',')}"  if variations.any?
      URL % spec
    end
  end

  helpers GoogleFontHelpers
end
