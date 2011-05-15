require File.expand_path("../../test_helper", __FILE__)

class UserProfileTest < UnitTest
  test "profile autocreate 1" do
    u = User.new
    u.profile

    assert u.profile.is_a?(Profile)
    assert u.profile.id == nil
    assert u.profile_id == nil
  end

  test "profile autocreate 2" do
    u = User.new
    u.profile_id = 'jinx'

    assert u.profile.is_a?(Profile)
    assert u.profile.id == 'jinx'
    assert u.profile_id == 'jinx'
  end

  test "profile autocreate 3" do
    u = User.new
    u.profile = Profile.new(id: 'mallow')

    assert u.profile.is_a?(Profile)
    assert u.profile.id == 'mallow'
    assert u.profile_id == 'mallow'
  end
end
