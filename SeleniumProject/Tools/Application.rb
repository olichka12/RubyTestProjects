require 'selenium-webdriver'
require_relative '../../SeleniumProject/Data/Data'
require_relative '../../SeleniumProject/Tools/Pages/HeadComponentPage'

class Application
  class << self
    def driver
      @driver ||= Selenium::WebDriver.for(:safari)

      # options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
      # @driver ||= Selenium::WebDriver.for :chrome, options: options
    end

    def get_url(url)
      @driver.get url
    end

    def maximize_window
      @driver.manage.window.maximize
    end

    def head_page
      HeadComponentPage.new
    end

    def quit_application
      @driver.quit
    end

    # take screenshots immediately
    def run
      driver
      begin
        yield
      rescue RSpec::Expectations::ExpectationNotMetError => error
        puts error.message
        @driver.save_screenshot "./#{Time.now.strftime("failshot__%d_%m_%Y__%H_%M_%S")}.png"
      end
      teardown
    end
  end
end
