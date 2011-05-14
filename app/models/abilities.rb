module Abilities
  def self.for(level)
    if level >= 100
      Abilities::Root.new
    else
      Abilities::Base.new
    end
  end
end

class Abilities::Base
  def can?(verb, noun=nil)
    false
  end
end

class Abilities::Root < Abilities::Base
  def can?(verb, noun=nil)
    return true  if [verb, noun] == [:login, :admin]

    super
  end
end
