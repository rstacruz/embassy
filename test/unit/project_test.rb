require File.expand_path("../../test_helper", __FILE__)

class ProjectTest < UnitTest
  setup do
    names = %w(alpha bravo charlie delta echo foxtrot golf)
    @cats = names.map { |name| Category.spawn!(name: name) }

    @user    = User.spawn!
    @profile = @user.profile
  end

  test "#category_hash" do
    project = Project.spawn(profile: @profile)

    project.category_hash = {
      alpha: "0", bravo: "1",
      charlie: "1", delta: "0"
    }

    assert project.category_names == %w(bravo charlie)

    project.save

    assert project.category_names == %w(bravo charlie)

    project = Project[project.id]

    assert project.category_names == %w(bravo charlie)
  end
end
