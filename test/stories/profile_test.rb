require File.expand_path("../../story_helper", __FILE__)

class ProfileStory < StoryTest
  setup do
    names = %w(animation design fashion)
    names.each { |name| Category.spawn! name: name }

    register_with email: 'liz@mcnamara-troy.com',
      password: 'yoplait',
      profile_name: 'liz',
      display_name: "Elizabeth Cruz"
  end

  test "edit profile" do
    visit "/profile/edit"
    fill_in "profile[location]", with: "Prague"
    fill_in "profile[behance]", with: "rstacruz"
    fill_in "profile[behance]", with: "rstacruz"
    check "Animation"
    check "Fashion"

    click_button "Save"

    Profile['liz'].location.should == "Prague"
    Profile['liz'].display_name.should == "Elizabeth Cruz"
    Profile['liz'].behance.should == "rstacruz"
  end
end
