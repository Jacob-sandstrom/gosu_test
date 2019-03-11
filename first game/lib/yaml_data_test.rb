require 'yaml'

data = YAML.load(File.read("animation_data.yaml"))

puts data["attack_down"]["frames"][0]["image"]