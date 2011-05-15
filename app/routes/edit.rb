class Main
  before '/profile/*' do
    ensure_authenticated!
  end

  get '/profile' do
    ensure_authenticated!
    redirect R(my_profile)
  end

  get '/profile/edit' do
    @profile = my_profile
    haml :'profiles/edit'
  end

  post '/profile/edit' do
    @profile = my_profile

    begin
      @profile.update params['profile']
      flash "Updated your profile."

      redirect '/profile/edit'

    rescue Sequel::ValidationFailed
      @errors = @profile.errors
      haml :'profiles/edit'
    end
  end

  get '/profile/upload' do
    @project = Project.new

    haml :'profiles/upload'
  end
end
