require_relative '../test_helper'

class ImageTest < UnitTest
  setup do
    @user    = User.spawn!
    @profile = @user.profile
    @project = Project.spawn!(profile: @profile)
  end

  test "image creation" do
    image = Image.spawn(project: @project)
    image.save

    image.project.should == @project

    id = image.id
    Image[id].project.should == @project

    @project.images.should == [image]
  end

  test "multi images" do
    images = (0..5).map { Image.spawn(project: @project).save }

    @project.images.should == images
  end

  test "deletion" do
    image = Image.spawn!(project: @project)

    @project.images.size.should == 1

    image.destroy

    Project[@project.id].images.should.be.empty
  end
end
