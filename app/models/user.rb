# A user.
#
# == Schema
#
#   primary_key :id
#   text :email
#   text :crypted_password
#
#   Numeric :level
#
class User < Sequel::Model
  extend Shield::Model

  one_to_one :profile

  # ----------------------------------------------------------------------------

  def self.fetch(str)
    user   = first(email: str)
    user ||= (profile = Profile[str]) && profile.user
    user
  end

  def validate
    super

    errors.add(:password, 'is not present')  if @password.to_s.empty?
    errors.add(:password, 'does not match')  if (!@password.to_s.empty? || !@password_confirmation.to_s.empty?) && @password != @password_confirmation

    if @profile
      @profile.valid?
      errors[:profile_name] += @profile.errors[:name]
      errors[:display_name] += @profile.errors[:display_name]
    end

    validates_presence :email
    validates_unique :email
    validates_format /@/, :email, message: 'is not a valid email'
  end

  # ----------------------------------------------------------------------------

  def password=(password)
    self.crypted_password = Shield::Password.encrypt(password)

    @password = password
  end

  def password_confirmation=(password)
    @password_confirmation = password
  end

  def profile_name=(v)
    raise "Not available unless new"  unless new?
    @profile_name = v
  end

  def profile_name
    @profile_name ||= (profile.name  if profile)
  end

  def display_name=(v)
    raise "Not available unless new"  unless new?
    @display_name = v
  end

  def display_name
    @display_name ||= (profile.display_name  if profile)
  end

  def abilities
    @abilities ||= Abilities.for(self.level)
  end

  def can?(verb, noun=nil)
    abilities && abilities.can?(verb, noun)
  end

  # ----------------------------------------------------------------------------
  # Hooks

  def after_create
    @profile.save

    self.update profile_id: @profile.id
  end

  def before_validation
    @profile = Profile.new(user: self, name: profile_name, display_name: display_name)
  end

  def before_destroy
    profile.delete
  end
end
