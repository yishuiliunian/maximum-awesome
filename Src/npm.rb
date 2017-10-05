require_relative 'utilities.rb'

def npm_install(app)
  sh "npm install -g #{app}"
end

def npm_install_apps(apps)
  if (not apps.nil?) and apps.count > 0
    apps.each { |app| npm_install app }
  end
end

namespace :install do
  desc "npm applications"
  task :npm_applications do
    step "Install npm applications"
    apps = load_plugins("npm")
    npm_install_apps(apps)
  end
end
