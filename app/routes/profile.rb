class Main
  before '/:profile/?*' do |id, _|
    @profile = Profile[id] or pass
  end

  get '/:profile' do |id|
    pass unless  @profile
    @projects = @profile.projects
    
    haml :'profiles/show'
  end
end
