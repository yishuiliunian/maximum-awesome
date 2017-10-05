require_relative 'utilities.rb'
require_relative 'brew.rb'
require_relative 'cask.rb'
require 'rake'

namespace :install do
  desc "Install Pip"
  task :pip do
    step "Install Pip Python"
    sh "sudo easy_install pip"
  end

  desc "Install Pip Applications"
  task :pip_applications do
    step "Install Pip Applications"
    apps = load_plugins("pip")
    apps.each { |app|
      step "Pip Install #{app}"
      sh "sudo pip install #{app}"
    }
  end
end
