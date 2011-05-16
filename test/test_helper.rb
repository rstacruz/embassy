ENV["RACK_ENV"] = "test"
require 'spork'

Spork.prefork do
end

Spork.each_run do
end

require_relative '../init'
require_relative 'factories'

require 'capybara/dsl'

class UnitTest < Test::Unit::TestCase
  def fixture(file)
    File.open fixture_path(file)
    end

  def fixture_path(file)
    Main.root "test", "fixtures", file
  end

  setup do
    Main.models.each { |model| model.delete }
  end

  def t(*a)
    I18n::t *a
  end
end
