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

    def ensure_authenticated!
      ensure_authenticated User
    end

    def ensure_anonymous!
      back = request.referrer || '/'
      redirect back  if authenticated?
    end

    def my_profile
      current_user && current_user.profile
    end

    def my_profile?
      @profile == my_profile
    end
  end

  helpers UserHelpers
end

