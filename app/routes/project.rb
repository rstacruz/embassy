class Main
  # Upload a new project
  get '/profile/upload' do
    @project = Project.new

    haml :'projects/new'
  end

  # Upload a new project (post)
  post '/profile/upload' do
    @project = Project.new(profile: my_profile)

    begin
      @project.update params['project']

      flash t('flash.success')
      redirect R(my_profile, @project)

    rescue Sequel::ValidationFailed
      @errors = @project.errors

      flash t('flash.validation_failed')
      haml :'projects/new'
    end
  end

  # Before filter (/rstacruz/192-kittenwar/*)
  before '/:profile/:project/?*' do |_, id, _|
    pass  unless @profile
    @project = Project[id.to_i]  or pass

    pass unless @project.profile == @profile
  end

  # Project (/rstacruz/192-kittenwar)
  get '/:profile/:project' do
    pass  unless @project

    haml :'projects/show', layout: :'layouts/folio'
  end
end
