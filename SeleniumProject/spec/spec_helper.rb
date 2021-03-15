require_relative '../Tools/Application'
require_relative '../../SeleniumProject/Data/Data'
require_relative '../../SeleniumProject/Tools/Pages/HeadComponentPage'
require_relative '../../SeleniumProject/Tools/Pages/SearchProductGridPage'
require_relative '../../SeleniumProject/Tools/Pages/SearchCategoryProductGridPage'
require_relative '../../SeleniumProject/Tools/Pages/SearchFirmPage'
require_relative '../../SeleniumProject/Tools/Pages/CartProductPage'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'capybara/dsl'

Dir[File.dirname(__FILE__) + '/../page_object/*/*.rb'].each do |page_object|
  require page_object
end

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :safari)
end

Capybara.save_path = "#{Dir.pwd}/screenshots"

Capybara.default_driver = :selenium
Capybara.app_host = URL
Capybara.default_max_wait_time = 20
