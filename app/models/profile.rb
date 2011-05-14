# A profile.
#
class Profile < Sequel::Model
  many_to_many  :categories,
    left_id:    :profile_id,
    right_id:   :category_id,
    join_table: :categories_profiles

  many_to_many  :images,
    left_id:    :profile_id,
    right_id:   :image_id,
    join_table: :images_profiles

  def initialize(hash={}, *a)
    id = hash.is_a?(Hash) && (hash.delete('id') || hash.delete(:id))

    super hash, *a

    self.id ||= id
    self.display_name ||= self.id
  end

  def validate
    super

    errors.add(:id, 'is not between 3 to 20 characters')  unless (3..20).include?(self.id.to_s.size)
  end

  def user=(v)
    @user = v
    self.user_id = v.id
  end

  def user
    @user ||= User[user_id]
  end
end
