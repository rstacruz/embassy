# Updates attributes from a hash.
# This was created because #update sometimes messes up with custom setters.
module Sequel::Plugins::UpdateAttributes
  module InstanceMethods
    def update_attributes(hash)
      hash.each { |k, v| send :"#{k}=", v }
    end
  end
end
