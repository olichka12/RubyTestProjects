require_relative '../tools/Application'
require_relative '../../SeleniumProject/Data/Data'
require_relative '../../SeleniumProject/tools/Pages/HeadComponentPage'
require_relative '../../SeleniumProject/tools/Pages/SearchProductGridPage'
require_relative '../../SeleniumProject/tools/Pages/SearchCategoryProductGridPage'
require_relative '../../SeleniumProject/tools/Pages/SearchFirmPage'
require_relative '../../SeleniumProject/tools/Pages/CartProductPage'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'capybara/dsl'

Dir[File.dirname(__FILE__) + '../spec'].each do |page_object|
  require page_object
end

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.save_path = "#{Dir.pwd}/screenshots"

Capybara.default_driver = :selenium
Capybara.app_host = URL
Capybara.default_max_wait_time = 20
