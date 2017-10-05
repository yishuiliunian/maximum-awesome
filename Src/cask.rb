require_relative 'utilities.rb'
require_relative 'brew.rb'
require 'rake'

def brew_cask_install(package, *options)
  output = `brew cask info #{package}`
  return unless output.include?('Not installed')

  sh "brew cask install --binarydir=#{`brew --prefix`.chomp}/bin #{package} #{options.join ' '}"
end

namespace :install do
  desc 'Install Homebrew Cask'
  task :brew_cask do
    step 'Homebrew Cask'
    system('brew untap phinze/cask') if system('brew tap | grep phinze/cask > /dev/null')
    unless system('brew tap | grep caskroom/cask > /dev/null') || system('brew tap caskroom/homebrew-cask')
      abort "Failed to tap caskroom/homebrew-cask in Homebrew."
    end

    unless system('brew tap | grep caskroom/drivers > /dev/null' || system('brew tap caskroom/drivers'))
      abort "Failed to tap caskroom/drivers in Homebrew"
    end

    brew_install 'brew-cask-completion'
  end

  desc "Applications From Brew cask"
  task :cask_applications do
    step "Install Applications From Cask"
    apps = load_plugins('brew_cask')
    apps.each { |app|
      step "Install #{app}"
      brew_cask_install app
    }
  end

end
