require 'yaml'

data = YAML.load(File.read("animation_data.yaml"))

p data["attack_down"]["frames"][0]["hitboxes"]