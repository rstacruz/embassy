class Main
  module FlashHelpers
    def flash(message=nil)
      if message.nil?
        session.delete :flash
      else
        session[:flash] = message
      end
    end

    def flash?
      !! session[:flash]
    end
  end

  helpers FlashHelpers
end

