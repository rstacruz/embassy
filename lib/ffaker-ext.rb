require 'ffaker'

module Faker::Lorem
  def self.title
    words(3+rand(3)).map(&:capitalize).join(' ')
  end
end
