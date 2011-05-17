require_relative '../test_helper'

class ProfileTest < UnitTest
  setup do
    @user     = User.spawn!
    @profile  = @user.profile
    @projects = (0..5).map { Project.spawn!(profile: @profile) }
  end

  test "#destroy" do
    Project.count.should == 6

    @profile.destroy

    Project.count.should == 0
    User.count.should == 0
  end
end

