# A profile.
#
class Profile < Sequel::Model
  RESTRICTED_NAMES = %w(profile you login logout register explore admin)

  unrestrict_primary_key

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

  def self.[](key)
    super key.to_s.downcase
  end

  def validate
    super
    self.id = self.id.downcase  if self.id.is_a?(String)

    id = self.id.to_s

    errors.add(:id, 'is not allowed')  if RESTRICTED_NAMES.include?(id)
    errors.add(:id, 'must be between 3 to 20 characters')  unless (3..20).include?(id.size)
    errors.add(:id, 'can only contain letters, numbers and underscores')  unless id =~ /^[A-Za-z0-9_]+$/
    errors.add(:id, 'must start with a letter')  unless id =~ /^[a-z]/

    [:behance, :dribbble, :twitter].each do |account|
      val = self.send(account).to_s.downcase
      self.send :"#{account}=", val  if self.send(account)

      errors.add account, 'is an invalid format'  if val.size > 1 && !(val =~ /^[a-z][a-z0-9_]*$/)
    end
  end

  def user=(v)
    @user = v
  end

  def user
    @user ||= User[user_id]
  end

  # ============================================================================ 
  # Hooks

  def before_save
    self.user_id = self.user.id  if self.user
  end

  def before_destroy
    self.user.delete
  end
end
