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

  def self.fetch(str)
    user   = first(email: str)
    user ||= (profile = Profile[str]) && profile.user
    user
  end

  def password=(password)
    self.crypted_password = Shield::Password.encrypt(password)

    @password = password
  end

  def password_confirmation=(password)
    @password_confirmation = password
  end

  def validate
    super

    errors.add(:password, 'is not present')  if @password.to_s.empty?
    errors.add(:password, 'does not match')  if (!@password.to_s.empty? || !@password_confirmation.to_s.empty?) && @password != @password_confirmation

    errors.add(:profile_id, 'is not present')  if self.profile_id.to_s.empty?
    errors.add(:profile_id, 'is not unique')   if Profile[self.profile_id]

    profile.valid?
    errors[:profile_id] += profile.errors[:id]

    validates_presence :email
    validates_unique :email
    validates_format /@/, :email, message: 'is not a valid email'
  end

  def profile
    @profile ||= Profile[profile_id]
    @profile ||= profile_id ? Profile.new(id: profile_id, user: self) : Profile.new(user: self)
  end

  def profile=(obj)
    @profile = obj.is_a?(Profile) ? obj : Profile.new(obj)
    self[:profile_id] = @profile.id
  end

  def profile_id=(id)
    @profile = nil
    super
  end

  # Seed
  #def self.update_data!
  #  Main.seed.users.each do |id, data|
  #    unless User.fetch(id)
  #      data[:email] = id
  #      data[:password_confirmation] = data[:password]
  #      User.create data
  #    end
  #  end
  #end

  def abilities
    @abilities ||= Abilities.for(self.level)
  end

  def can?(verb, noun=nil)
    abilities && abilities.can?(verb, noun)
  end

  def display_name
    profile && profile.display_name
  end

  # ============================================================================
  # Hooks

  def after_create
    self.profile.save
  end

  def before_destroy
    profile.delete
  end
end

