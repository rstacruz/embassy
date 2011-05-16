require File.expand_path("../../test_helper", __FILE__)

class UserProfileTest < UnitTest
  test "profile autocreate 4" do
    u = User.spawn profile_name: 'jinx'
    u.save

    u.profile.should.is_a?(Profile)
    u.profile.name.should == 'jinx'
    u.profile_name.should == 'jinx'
  end

  test "profile autocreate 2" do
    u = User.spawn
    u.profile_name = 'jinx'
    u.save

    u.profile.should.is_a?(Profile)
    u.profile.name.should == 'jinx'
    u.profile_name.should == 'jinx'
  end

  test "profile autocreate 3" do
    u = User.spawn!

    assert_raises RuntimeError do
      u.profile_name = 'jinx'
    end
  end

  test "profile edit" do
    Category.spawn! name: 'advertising'
    Category.spawn! name: 'animation'

    user    = User.spawn!
    profile = Profile[user.profile.name]

    profile.update "display_name"=>"Rico Sta Cruz", "location"=>"", "biography"=>"", "behance"=>"", "twitter"=>"", "dribbble"=>"", "category_hash"=>{"advertising"=>"0", "animation"=>"1"}
    profile.save

    %w(advertising animation).should == profile.categories.map(&:name).sort
  end
end
