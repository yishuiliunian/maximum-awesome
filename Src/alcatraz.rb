require_relative 'utilities.rb'
require_relative 'brew.rb'
require_relative 'cask.rb'
require_relative 'oymyzsh.rb'
require 'rake'

namespace :install do
  task :alcatraz do
    step "xcode pulgins mamager Alcatraz"
    sh 'curl -fsSL https://raw.githubusercontent.com/supermarin/Alcatraz/deploy/Scripts/install.sh | sh'
  end
end
