class Main
  get '/' do
    @profiles = Profile.all

    haml :home
  end
end

