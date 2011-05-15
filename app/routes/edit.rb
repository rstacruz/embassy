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

  get '/profile/upload' do
    @project = Project.new

    haml :'profiles/upload'
  end
end
