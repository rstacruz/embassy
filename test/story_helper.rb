require 'fileutils'

require File.expand_path('../test_helper', __FILE__)

class StoryTest < UnitTest
  include Capybara

  Capybara.register_driver :selenium_chrome do |app|
    Capybara::Driver::Selenium.new(app, :browser => :chrome)
  end

  case ENV['CAPYBARA_DRIVER']
    when 'chrome'  then Capybara.default_driver = :selenium_chrome
    when 'firefox' then Capybara.default_driver = :selenium
  end

  def self.javascript?
    [:selenium, :selenium_chrome].include?(Capybara.default_driver)
  end

  def self.javascript(name='', &blk)
    describe("JavaScript tests #{name}") { yield }   if javascript?
  end

  setup do
    Capybara.app = Main
  end

  def login!
    visit '/login'

    fill_in 'email',    with: 'liz@mcnamara-troy.com'
    fill_in 'password', with: 'password'

    click_button 'Login'
  end

  def register_with(hash)
    hash[:password_confirmation] ||= hash[:password]

    visit '/register'
    hash.each { |field, value| fill_in field.to_s, with: value }
    click_button "Register"
  end
end
