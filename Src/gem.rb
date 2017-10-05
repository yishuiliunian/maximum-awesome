require_relative 'utilities.rb'
def gem_install(app)
  sh("gem which #{app}",verbose: false) do | ok, status|
    unless  ok
      sh("gem install #{app}",verbose: false) do |ok2, status2|
        unless ok
          WARNING "Can't find #{app} to install , please check it !!!"
        end
      end
    end
  end
end

def gem_install_apps(apps)
  if (not apps.nil?) and apps.count > 0
    apps.each { |app| gem_install app }
  end
end

namespace :install do
  desc "Ruby Version Manager "
  task :rvm do
    step "Install RVM"
    sh "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB"
    sh "curl -sSL https://get.rvm.io | bash -s stable"
    sh "rvm install ruby-head"
    sh "rvm --default use ruby-head"
  end

  task :gem_applications do
    step "Install Gem Applications"
    apps = load_plugins("gem")
    gem_install_apps apps
  end
end
