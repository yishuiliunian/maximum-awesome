require_relative 'utilities.rb'
require_relative 'brew.rb'
require_relative 'cask.rb'
require 'rake'

namespace :install do
  desc 'Install iTerm'
  task :iterm do
    step 'iterm2'
    unless app? 'iTerm'
      brew_cask_install 'iterm2'
    end
  end

  desc "iTerm configuration"
  task :item_configuration do
    step "Configurate iterm2"
    step 'iterm2 colorschemes'
    colorschemes = `defaults read com.googlecode.iterm2 'Custom Color Presets'`
    dark  = colorschemes !~ /Solarized Dark/
    light = colorschemes !~ /Solarized Light/
    sh('open', '-a', '/Applications/iTerm.app', File.expand_path('iterm2-colors-solarized/Solarized Dark.itermcolors')) if dark
    sh('open', '-a', '/Applications/iTerm.app', File.expand_path('iterm2-colors-solarized/Solarized Light.itermcolors')) if light

    step 'iterm2 profiles'
    puts
    puts "  Your turn!"
    puts
    puts "  Go and manually set up Solarized Light and Dark profiles in iTerm2."
    puts "  (You can do this in 'Preferences' -> 'Profiles' by adding a new profile,"
    puts "  then clicking the 'Colors' tab, 'Load Presets...' and choosing a Solarized option.)"
    puts "  Also be sure to set Terminal Type to 'xterm-256color' in the 'Terminal' tab."
    puts
    puts "  Enjoy!"
    puts
  end

  desc "Item All"
  task :item_all=> [:iterm, :item_configuration] do
  end
  
end
