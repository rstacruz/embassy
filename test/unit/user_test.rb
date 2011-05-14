require File.expand_path("../../story_helper", __FILE__)

class UserTest < UnitTest
  setup do
  end

  test "the truth" do
    user = User.spawn
    name = user.username

    assert Profile[name] == user.profile
  end
end
