require_relative '../test_helper'

class ImageTest < UnitTest
  setup do
    @user    = User.spawn!
    @profile = @user.profile
    @project = Project.spawn!(profile: @profile)
  end

  test "image creation" do
    image = Image.new(project: @project)
    image.save

    image.project.should == @project

    id = image.id
    Image[id].project.should == @project

    @project.images.should == [image]
  end

  test "multi images" do
    images = (0..5).map { Image.new(project: @project).save }

    @project.images.should == images
  end
end
