require 'webrat' if !defined?(Webrat) # Because some people have it installed as a Gem

Given /a cucumber test (\w+) exists/ do |feature_name|
  path = File.expand_path(File.dirname(__FILE__) + "/#{feature_name}.feature")
  File.exist?(path).should be_true
end

When /I visit the rcumber landing page/ do
  visits "/rcumbers"
end
