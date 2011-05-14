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

  one_to_one   :profile

  def self.fetch(email)
    first email: email
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

    validates_presence :email
    validates_unique :email
    validates_format /@/, :email, message: 'is not a valid email'
  end

  def profile
    self[:profile] || (profile_id && Profile[profile_id])
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
  
  def after_create
    profile      = Profile.new
    profile.id   = username
    profile.user = self
    profile.save
  end
end

