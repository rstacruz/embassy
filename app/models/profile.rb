# A profile.
#
class Profile < Sequel::Model
  one_to_one    :user

  many_to_many  :categories,
    left_id:    :profile_id,
    right_id:   :category_id,
    join_table: :categories_profiles

  many_to_many  :images,
    left_id:    :profile_id,
    right_id:   :image_id,
    join_table: :images_profiles

  def initialize(*a)
    super

    self.display_name ||= self.id
  end
end
