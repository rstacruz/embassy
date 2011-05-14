class Main
  before '/:profile/?*' do |id, _|
    @profile = Profile[id] or pass
  end

  get '/:profile' do |id|
    @profile = Profile[id] or pass
    
    haml :'profiles/show'
  end

  get '/:profile/edit' do
    pass  unless @profile
    
    haml :'profiles/edit'
  end

  get '/:profile/upload' do
    pass  unless @profile
    
    haml :'profiles/upload'
  end
end
