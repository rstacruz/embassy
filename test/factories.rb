def User.build(hash={})
  hash[:email]                 ||= Faker::Internet.email
  hash[:password]              ||= 'password'
  hash[:password_confirmation] ||= hash[:password]
  hash[:profile_name]          ||= 'the' + Faker::Lorem.word.downcase

  user = User.new(hash)
end

def User.spawn(hash={})
  build(hash).save
end
