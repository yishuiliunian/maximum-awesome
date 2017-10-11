require_relative 'utilities.rb'
require_relative 'brew.rb'
require_relative 'cask.rb'
require_relative 'oymyzsh.rb'
require 'rake'


namespace :install do
  desc "Atom"
  task :atom do
    step "atom"
    brew_cask_install 'atom'

    step "Atom Plugins"
    plugins = load_plugins('atom')
    plugins.each {|plugin|
       sh "apm install #{plugin}"
    }
  end
end
