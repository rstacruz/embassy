class Main
  before '/:profile/?*' do |id, _|
    @profile = Profile[id] or pass
  end

  get '/:profile' do |id|
    @profile = Profile[id] or pass
    
    haml :'profiles/show'
  end
end
