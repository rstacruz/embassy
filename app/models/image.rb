class Image < Sequel::Model
  many_to_one :project
  many_to_one :profile
end
