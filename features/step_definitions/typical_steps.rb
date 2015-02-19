When(/^I launch the sample application and press '(.+)'$/) do |button_text|
  button(button_text).click
end

When(/^I complete the registration process$/) do
  # Assumes the user has registered previously, and so will get the known user flow

  # We have to explicitly wait for elements, probably because of this:
  # https://github.com/appium/appium/issues/3682
  # Also, this takes forever on the Android simulator
  wait_true(120) {
    sleep(5)
    find('Enter your mobile phone number')
  }
  first_textfield.click
  first_textfield.type('123123123123')
  button('Continue').click

  wait_true { find('Enter verification code') }
  first_textfield.click
  first_textfield.type('1248')

  wait_true { find('Hi Testperson-se') }
  button('Done').click
end

Then(/^I should see a QR code for the ticket I bought$/) do
  wait_true { find('Change payment preferences') }

  case appium_device
  when :ios
    wait_true {
      image_sizes = find_elements(:class_name, 'UIAImage').select(&:displayed?).map(&:size).map(&:values)
      expect(image_sizes).to include([240, 240])
    }
  when :android
    wait_true {
      find("qr code image")
    }
  else
    raise 'Unsupported device'
  end
end
