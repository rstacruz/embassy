class Main
  before '/category/:category/?*' do |id, _|
    @category = Category[id]  or pass
  end

  get '/category/:category' do |_|
    pass unless @category

    haml :'categories/show'
  end
end
