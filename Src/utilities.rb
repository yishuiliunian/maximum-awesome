require "rake"

def step(description)
  description = "-- #{description} "
  description = description.ljust(80, '-')
  puts
  puts "\e[32m#{description}\e[0m"
end

def WARNING(message)
  puts
  puts "\e[31m#{message}\e[0m"
end

def load_plugins(file)
  array = []
  File.readlines('ApplicationPlugins/'+"#{file}.plugins").each { |plugin|
    plugin = plugin.gsub(/#.*#/,"")
    plugin = plugin.gsub(/\n/,"")
    key =  plugin.gsub(/\s+/,"")
    if key.length != 0
      array << plugin
    end
  }
  return array
end
