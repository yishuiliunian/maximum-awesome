require_relative "Src/fudation.rb"

ENV['HOMEBREW_CASK_OPTS'] = "--appdir=/Applications"


def get_backup_path(path)
  number = 1
  backup_path = "#{path}.bak"
  loop do
    if number > 1
      backup_path = "#{backup_path}#{number}"
    end
    if File.exists?(backup_path) || File.symlink?(backup_path)
      number += 1
      next
    end
    break
  end
  backup_path
end




namespace :install do

  task :alcatraz do
    step "xcode pulgins mamager Alcatraz"
    sh 'curl -fsSL https://raw.githubusercontent.com/supermarin/Alcatraz/deploy/Scripts/install.sh | sh'
  end

  desc "Mananger application cmd"
  task :mas do
    step "mas : Mac Apple Store Applications"
    brew_install 'mas'
    applications = load_plugins('mas')
    applications.each { |app|
      sh "mas install #{app}"
    }
  end

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



COPIED_FILES = filemap(
  'vimrc.local'         => '~/.vimrc.local',
  'vimrc.bundles.local' => '~/.vimrc.bundles.local',
)

LINKED_FILES = filemap(
  'vim'           => '~/.vim',
  'vimrc'         => '~/.vimrc',
  'vimrc.bundles' => '~/.vimrc.bundles',
  'zshrc'         => '~/.zshrc'
)



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
  Rake::Task['install:macvim'].invoke
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



  # TODO install gem ctags?
  # TODO run gem ctags?

  step 'symlink'

  LINKED_FILES.each do |orig, link|
    link_file orig, link
  end

  COPIED_FILES.each do |orig, copy|
    cp orig, copy, :verbose => true unless File.exist?(copy)
  end

  # Install Vundle and bundles
  Rake::Task['install:vundle'].invoke


end


desc 'Uninstall these config files.'
task :uninstall do
  step 'un-symlink'

  # un-symlink files that still point to the installed locations
  LINKED_FILES.each do |orig, link|
    unlink_file orig, link
  end

  # delete unchanged copied files
  COPIED_FILES.each do |orig, copy|
    rm_f copy, :verbose => true if File.read(orig) == File.read(copy)
  end

  step 'homebrew'
  puts
  puts 'Manually uninstall homebrew if you wish: https://gist.github.com/mxcl/1173223.'

  step 'iterm2'
  puts
  puts 'Run this to uninstall iTerm:'
  puts
  puts '  rm -rf /Applications/iTerm.app'

  step 'macvim'
  puts
  puts 'Run this to uninstall MacVim:'
  puts
  puts '  rm -rf /Applications/MacVim.app'
end

task :default => :install
