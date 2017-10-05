require_relative 'utilities.rb'
require_relative 'brew.rb'
require_relative 'cask.rb'
require 'rake'
def configurete_hammerspoon()
  step "Install hammerspoon"
  brew_cask_install "hammerspoon"
  step "Configureate Hammerspoon"
  path = ENV['HOME']+"/.hammerspoon"
  if Dir.exist?(path)
    WARNING "#{path} exist , will not configurate it. if you want force configurate, please remove it manually."
    step "UPDATE IT!!"
    sh "cd ~/.hammerspoon && git pull", verbose: false
  else
    sh "git clone --depth 1 https://github.com/ashfinal/awesome-hammerspoon.git ~/.hammerspoon", verbose:false
  end
end

namespace :install do
  desc "Install & Configuration Hammerspoon [Magic Atommation Tools, Windows manage and so on]"
  task :hammerspoon do
    configurete_hammerspoon
  end
end
