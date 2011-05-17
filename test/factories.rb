require 'ffaker-ext'

# Returns a word that matches the given block's condition
def word(options={}, &blk)
  while true
    word = Faker::Lorem.word
    break if yield(word)
  end

  word
end

def User.spawn(hash={})
  hash[:email]        ||= Faker::Internet.email
  hash[:password]     ||= 'password'
  hash[:profile_name] ||= word { |w| (3..20).include?(w.length) && Profile[w].nil? }
  hash[:display_name] ||= Faker::Name.name

  User.new(hash)
end

def User.spawn!(hash={})
  spawn(hash).save
end

def Project.spawn(hash={})
  hash[:name]           ||= Faker::Lorem.title
  hash[:category_names] ||= [(Category.random || Category.spawn!).name]

  Project.new(hash)
end

def Project.spawn!(hash={})
  spawn(hash).save
end

def Category.spawn(hash={})
  hash[:name] ||= word { |w| Category[w].nil? }
  Category.new(hash)
end

def Category.spawn!(hash={})
  spawn(hash).save
end

class Sequel::Model
  def self.random
    all.shuffle.first
  end
end
