require File.expand_path("../../story_helper", __FILE__)

class RegisterTest < StoryTest
  def register_with(hash)
    hash[:password_confirmation] ||= hash[:password]

    visit '/register'
    hash.each { |field, value| fill_in field.to_s, with: value }
    click_button "Register"
  end

  test "successful registration" do
    register_with email: 'liz@mcnamara-troy.com',
      password: 'yoplait',
      username: 'liz'

    assert page.has_no_css?('.error')

    assert User.fetch('liz@mcnamara-troy.com')
    assert User.fetch('liz')
  end

  test "failed registration (not matching)" do
    register_with email: 'liz@mcnamara-troy.com',
      password: 'yoplait',
      password_confirmation: 'yoplait_not',
      username: 'liz'

    assert page.has_content?('does not match')
    assert User.all.empty?
  end

  test "failed registration (no pw)" do
    register_with email: 'liz@mcnamara-troy.com',
      username: 'liz'

    assert page.has_content?('is not present')
    assert User.all.empty?
  end

  test "failed registration (duplicate username)" do
    register_with email: 'liz@mcnamara-troy.com',
      password: 'xyz',
      username: 'zig'

    visit '/logout'

    register_with email: 'quentin@mcnamara-troy.com',
      password: 'abc',
      username: 'zig'

    assert page.has_content?('is not unique')

    assert User.fetch('liz@mcnamara-troy.com')
    assert ! User.fetch('quentin@mcnamara-troy.com')
  end

  test "failed registration (username too short)" do
    register_with email: 'liz@mcnamara-troy.com',
      password: 'xyz',
      username: 'z'

    assert User.all.empty?
  end

  javascript do
    test "A JavaScript test" do
      visit "/"
    end
  end
end
