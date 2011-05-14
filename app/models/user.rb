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
    errors.add(:password, 'does not match')  if (!@password.to_s.empty? || !@password_confirmation.to_s.empty?) && @password != @password_confirmation
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
end

