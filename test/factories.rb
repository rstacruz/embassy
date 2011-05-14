def User.spawn(hash={})
  hash[:email]                 ||= Faker::Internet.email
  hash[:password]              ||= 'password'
  hash[:password_confirmation] ||= hash[:password]
  hash[:username]              ||= Faker::Lorem.word.downcase

  user = User.new
  user.update hash
  user
end
