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

  def self.fetch(email)
    user   = first(email: email)
    user ||= (profile = Profile[email]) && profile.user
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
    errors.add(:username, 'is not present')  if @username.to_s.empty?
    errors.add(:username, 'is not unique')   if Profile[@username]

    profile.valid?
    errors[:username] += profile.errors[:id]

    validates_presence :email
    validates_unique :email
    validates_format /@/, :email, message: 'is not a valid email'
  end

  def profile
    @profile ||= Profile[profile_id]
    @profile ||= Profile.new(id: @username, user: self)
  end

  def profile=(obj)
    @profile = (obj.is_a?(Profile) || Profile.new(obj))
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

  def username
    @username ||= profile.id  if profile
    @username
  end

  def display_name
    profile && profile.display_name
  end

  def username=(v)
    @username = v
  end

  # ============================================================================ 
  # Hooks

  def before_save
    self.profile_id = self.profile.id  if self.profile
  end
  
  def after_create
    self.profile.save
  end

  def before_destroy
    profile.delete
  end
end

