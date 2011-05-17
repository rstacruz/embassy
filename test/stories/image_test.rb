require File.expand_path("../../story_helper", __FILE__)

class ImageStory < StoryTest
  setup do
    register_with email: 'liz@mcnamara-troy.com',
      password: 'yoplait',
      profile_name: 'liz',
      display_name: "Elizabeth Cruz"

    @user    = User.first
    @profile = @user.profile
    @project = Project.spawn!(profile: @profile)
  end

  test "upload image" do
    @project.images.should.be.empty

    visit R(@profile, @project, :add)
    attach_file 'image_file', fixture_path('images/nyancat.png')
    click_button 'go'

    Image.count.should == 1
  end
end
