require 'selenium/webdriver'
require 'capybara-screenshot/rspec'

Capybara.javascript_driver = :selenium_chrome_headless

Capybara::Screenshot.register_driver(:selenium_chrome_headless) do |driver, path|
  driver.browser.save_screenshot(path)
end

RSpec.configure do |config|

  config.before(:each) do
    if  ENV['HEADLESS'] == 'true'
      Capybara.current_driver = :selenium_chrome_headless
    else
      Capybara.current_driver = :selenium_chrome
    end
  end
end
