ENV["RACK_ENV"] = "test"
require 'spork'

Spork.prefork do
end

Spork.each_run do
end

require_relative '../init'
require_relative 'factories'

require 'renvy'
require 'capybara/dsl'

Imagery.send :include, Imagery::Faking
Imagery.mode = :fake

class UnitTest < Test::Unit::TestCase
  def fixture(file)
    File.open fixture_path(file)
    end

  def fixture_path(file)
    Main.root "test", "fixtures", file
  end

  def db
    Main.database
  end

  setup do
    Main.database.tables.each { |t| db[t].delete }
  end

  def t(*a)
    I18n::t *a
  end
end
