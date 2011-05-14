require File.expand_path("../../test_helper", __FILE__)

class UserTest < UnitTest
  setup do
    @user = User.spawn
    @name = @user.username
  end

  test "profile autocreate" do
    assert Profile[@name] == @user.profile
  end

  test "restricted names" do
    begin
      User.spawn username: "login"
      assert false
    rescue Sequel::ValidationFailed => e
      assert e.errors[:username].include?('is not allowed')
    end
  end

  test "stupid number" do
    begin
      User.spawn username: "0ahu"
      assert false
    rescue Sequel::ValidationFailed => e
      assert e.errors[:username].include?('must start with a letter')
    end
  end

  describe "lowercase" do
    setup do
      @user = User.spawn(username: "EdwardK")
    end

    test "user access" do
      assert User.fetch('edwardk') == @user
      assert User.fetch('EdwardK') == @user
      assert User.fetch('EDWARDK') == @user
    end

    test "profile access" do
      assert Profile['edwardk'].user == @user
      assert Profile['EdwardK'].user == @user
      assert Profile['EDWARDK'].user == @user
    end
  end

  test "profile autodelete" do
    @user.destroy
    assert Profile.all.empty?
    assert User.all.empty?
  end

  test "profile autodelete (backwards)" do
    @user.profile.destroy
    assert Profile.all.empty?
    assert User.all.empty?
  end
end
