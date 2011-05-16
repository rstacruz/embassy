require File.expand_path("../../test_helper", __FILE__)

class UserProfileTest < UnitTest
  test "profile autocreate 4" do
    u = User.build profile_name: 'jinx'
    u.save

    assert u.profile.is_a?(Profile)
    assert u.profile.name == 'jinx'
    assert u.profile_name == 'jinx'
  end

  test "profile autocreate 2" do
    u = User.build
    u.profile_name = 'jinx'
    u.save

    assert u.profile.is_a?(Profile)
    assert u.profile.name == 'jinx'
    assert u.profile_name == 'jinx'
  end

  test "profile autocreate 3" do
    u = User.build.save

    assert_raises RuntimeError do
      u.profile_name = 'jinx'
    end
  end
end
