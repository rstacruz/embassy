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
      @profile.update_attributes params['profile']
      @profile.save

      flash t('edit_profile.flash.success')

      redirect R(my_profile)

    rescue Sequel::ValidationFailed
      @errors = @profile.errors

      flash t('flash.validation_failed')
      haml :'profiles/edit'
    end
  end
end
