class Main
  module I18nHelpers
    def tc(*a)
      t(*a).to_s + ":"
    end
  end

  helpers I18nHelpers
end
