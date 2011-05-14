class Main
  get '/register' do
    ensure_anonymous!

    @user = User.new
    haml :'/user/register'
  end

  post '/register' do
    ensure_anonymous!

    @user = User.new

    begin
      @user.update(params['user'])
      flash "Okay."
      login(User, @user.email, params['user']['password'])
      redirect '/'

    rescue Sequel::ValidationFailed
      @errors = @user.errors
      haml :'/user/register'
    end
  end

  get '/login' do
    ensure_anonymous!

    haml :'user/login'
  end

  post '/login' do
    ensure_anonymous!

    if login(User, params[:username], params[:password])
      redirect '/'
    else
      @error = "Can't log you in."
      haml :'user/login'
    end
  end

  get '/logout' do
    ensure_authenticated!
    logout User

    flash "You have logged out."
    redirect '/'
  end

  before '/admin/*' do |page|
    ensure_authenticated!
  end
end
