require_relative 'utilities.rb'
require_relative 'brew.rb'
require_relative 'cask.rb'
require 'rake'

namespace :install do
  task :ohmyzsh do
    step "oh my zsh"
    sh 'sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'
    step "Install antigen ---ZSH Plugins Manager"
    brew_install "antigen"
  end
end
