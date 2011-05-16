# A profile.
#
class Profile < Sequel::Model
  unrestrict_primary_key

  one_to_many   :projects

  many_to_many  :categories,
    left_id:    :profile_id,
    right_id:   :category_id,
    join_table: :categories_profiles

  many_to_many  :images,
    left_id:    :profile_id,
    right_id:   :image_id,
    join_table: :images_profiles

  # ----------------------------------------------------------------------------
  # Constants

  RESTRICTED_NAMES = %w(profile you login logout register explore admin)

  # ----------------------------------------------------------------------------
  
  def initialize(*a)
    super
  end

  def self.[](key)
    super || first(name: key.to_s.downcase)
  end

  def validate
    super

    errors.add(:name, 'is not allowed')  if RESTRICTED_NAMES.include?(name)
    errors.add(:name, 'must be between 3 to 20 characters')  unless (3..20).include?(name.size)
    errors.add(:name, 'can only contain letters, numbers and underscores')  unless name =~ /^[A-Za-z0-9_]+$/
    errors.add(:name, 'must start with a letter')  unless name =~ /^[a-z]/

    validates_presence :display_name

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

  def to_param
    name
  end

  # ---------------------------------------------------------------------------- 
  # Hooks

  def before_validation
    self.name = self.name.to_s.downcase
  end

  def before_save
    self.user_id = self.user.id  if self.user
  end

  def before_destroy
    self.user.delete
  end
end
