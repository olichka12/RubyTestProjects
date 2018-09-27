require 'selenium-webdriver'
require_relative '../../SeleniumProject/Data/Data'
require_relative '../../SeleniumProject/Tools/Pages/HeadComponentPage'

class Application
  class << self
    def driver
      @driver ||= Selenium::WebDriver.for(:safari)
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
  end
end
