require_relative "Src/fudation.rb"

ENV['HOMEBREW_CASK_OPTS'] = "--appdir=/Applications"






namespace :install do
  task :alcatraz do
    step "xcode pulgins mamager Alcatraz"
    sh 'curl -fsSL https://raw.githubusercontent.com/supermarin/Alcatraz/deploy/Scripts/install.sh | sh'
  end
end

desc 'Install these config files.'
task :install do
  Rake::Task['install:brew'].invoke
  Rake::Task['install:brew_cask'].invoke
  Rake::Task['install:brew_applications'].invoke
  Rake::Task['install:cask_applications'].invoke
  Rake::Task['install:the_silver_searcher'].invoke
  Rake::Task['install:item_all'].invoke
  Rake::Task['install:reattach_to_user_namespace'].invoke
  Rake::Task['install:tmux_all'].invoke
  Rake::Task['install:vim'].invoke
  Rake::Task['install:rvm'].invoke
  Rake::Task['install:gem_applications'].invoke
  Rake::Task['install:pip'].invoke
  Rake::Task['install:pip_applications'].invoke
  Rake::Task['install:hammerspoon'].invoke
  Rake::Task['install:macport'].invoke
  Rake::Task['install:npm_applications'].invoke
  Rake::Task['install:mas'].invoke
  # Rake::Task['install:alcatraz'].invoke
  Rake::Task['install:ohmyzsh'].invoke
end


task :default => :install
