# Copy all the stuff from here: https://github.com/appium/sample-code/blob/master/sample-code/examples/ruby/cucumber_ios/features/support/env.rb

require 'rspec/expectations'
require 'appium_lib'
require 'cucumber/ast'

# Create a custom World class so we don't pollute `Object` with Appium methods
class AppiumWorld
end

capabilities = {
  platformName:    ENV['PLATFORM'] || (raise 'Please supply the desired platform'),
  app:             ENV['APP_LOCATION'] || (raise 'Please specify the app\'s location')
}

capabilities[:platformName] = capabilities[:platformName].downcase.to_sym

case capabilities[:platformName]
when :ios
  capabilities.merge!({
    deviceName:      ENV['DEVICE_NAME'] || 'iPhone 6',
    platformVersion: ENV['PLATFORM_VERSION'] || '8.1'
  })
when :android
  capabilities.merge!({
    deviceName:      ENV['DEVICE_NAME'] || 'Android Emulator',
    platformVersion: ENV['PLATFORM_VERSION'] || '4.4'
  })
end

Appium::Driver.new(caps: capabilities)
Appium.promote_appium_methods AppiumWorld

World do
  AppiumWorld.new
end

Before { $driver.start_driver }
After { $driver.driver_quit }
