require_relative 'utilities.rb'
require_relative 'brew.rb'
require_relative 'cask.rb'
require_relative 'oymyzsh.rb'
require 'rake'

namespace :install do
  desc "Mananger application cmd"
  task :mas do
    step "mas : Mac Apple Store Applications"
    brew_install 'mas'
    applications = load_plugins('mas')
    applications.each { |app|
      sh "mas install #{app}"
    }
  end
end
