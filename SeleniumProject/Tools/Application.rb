require 'selenium-webdriver'
require_relative '../../SeleniumProject/Data/Data'
#require_relative 'HeadComponentPage'

class Application
  def self.get
    @driver = Selenium::WebDriver.for(:safari)
    @driver.manage.window.maximize
    @driver.get URL

    @driver
    #HeadComponentPage.new(@driver)
  end

  def self.quit_application
    @driver.quit
  end
end
