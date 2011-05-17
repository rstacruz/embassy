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

      flash t('user.flash.register_success')
      login(User, @user.email, params['user']['password'])
      redirect R(@user.profile)

    rescue Sequel::ValidationFailed
      @errors = @user.errors

      flash t('user.flash.register_fail')
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
      flash t('user.flash.login_fail')
      haml :'user/login'
    end
  end

  get '/logout' do
    ensure_authenticated!
    logout User

    flash t('user.flash.logout_success')
    redirect '/'
  end

  before '/admin/*' do |page|
    ensure_authenticated!
  end
end
