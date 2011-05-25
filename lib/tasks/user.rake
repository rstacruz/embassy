namespace :user do
  desc "Resets a user's password [User]"
  task :reset, :username do |_, args|
    user = get_user args[:username]

    passwd = "Embassy"
    user.update password: passwd
    puts "Password for user '#{user}' has been set to '#{passwd}'."
  end

  desc "Lists users [User]"
  task :list do
    require './init'

    User.each { |u| puts " * #{u} (#{u.profile_name})" }
  end
end

def get_user(username)
  taskname = "user:reset"

  if username.nil?
    $stderr << "Usage: rake #{taskname}[username]\n"
    exit 1
  end

  require './init'

  user = User.fetch username
  if user.nil?
    $stderr << "User '#{username}' not found.\n"
    exit 1
  end

  user
end
