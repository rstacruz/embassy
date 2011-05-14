class Main
  module UserHelpers
    def current_user
      authenticated(User)
    end

    def authenticated?
      !! current_user
    end

    def redirect_to_login
      redirect '/login'
    end

    def ensure_anonymous
      back = request.referrer || '/'
      redirect back  if authenticated?
    end
  end

  helpers UserHelpers
end

