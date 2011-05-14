class Main
  get '/:profile' do |id|
    @profile = Profile[id] or pass
    
    haml :'profiles/show'
  end
end
