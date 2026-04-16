source "https://rubygems.org"

ruby File.read(".tool-versions").scan(/^ruby (.+)$/).first.first.strip

gem "fastlane"
gem "dotenv"

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')

android_plugins = File.join(File.dirname(__FILE__), 'android', 'fastlane', 'Pluginfile')
eval_gemfile(android_plugins) if File.exist?(android_plugins)

ios_plugins = File.join(File.dirname(__FILE__), 'ios', 'fastlane', 'Pluginfile')
eval_gemfile(ios_plugins) if File.exist?(ios_plugins)
