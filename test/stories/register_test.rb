require File.expand_path("../../story_helper", __FILE__)

class RegisterTest < StoryTest
  test "successful registration" do
    register_with email: 'liz@mcnamara-troy.com',
      password: 'yoplait',
      profile_name: 'liz',
      display_name: "Elizabeth Cruz"

    assert page.has_no_css?('.error')

    assert User.fetch('liz@mcnamara-troy.com')
    assert User.fetch('liz')
  end

  test "successful registration with display name" do
    register_with email: 'liz@mcnamara-troy.com',
      password: 'yoplait',
      profile_name: 'liz',
      display_name: "Elizabeth Cruz"

    assert Profile['liz'].display_name == "Elizabeth Cruz"
  end

  test "failed registration (not matching)" do
    register_with email: 'liz@mcnamara-troy.com',
      password: 'yoplait',
      password_confirmation: 'yoplait_not',
      profile_name: 'liz'

    assert page.has_content?(t('errors.does_not_match'))
    assert User.all.empty?
  end

  test "failed registration (no pw)" do
    register_with email: 'liz@mcnamara-troy.com',
      profile_name: 'liz'

    assert page.has_content?(t('errors.is_not_present'))
    assert User.all.empty?
  end

  test "failed registration (duplicate profile_name)" do
    register_with email: 'liz@mcnamara-troy.com',
      password: 'xyz',
      display_name: 'Elizabeth Cruz',
      profile_name: 'lior'

    visit '/logout'

    register_with email: 'quentin@mcnamara-troy.com',
      password: 'abc',
      display_name: 'Elizabeth Cruz',
      profile_name: 'lior'

    assert page.has_content?(t('errors.is_already_taken'))

    assert User.fetch('liz@mcnamara-troy.com')
    assert ! User.fetch('quentin@mcnamara-troy.com')
  end

  test "failed registration (profile_name too short)" do
    register_with email: 'liz@mcnamara-troy.com',
      password: 'xyz',
      profile_name: 'z'

    assert User.all.empty?
  end

  javascript do
    test "A JavaScript test" do
      visit "/"
    end
  end
end
