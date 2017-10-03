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
