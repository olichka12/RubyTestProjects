class HeadComponentPage
  LOGO = {css: '.logo.col-lg-3.col-md-3.col-sm-3.col-xs-3'}
  SEARCH_INPUT = {name: 'q'}
  SEARCH_BUTTON = {css: '.button-search'}
  POSTPONED = {xpath: "//div[@class='wrapper-wishlist']//i"}
  COMPARE = {css: '.icon-balance'}
  COMPARE_QUANTITY = {id: 'compare-quantity'}
  CART = {css: '.icon-cart'}
  CART_QUANTITY = {id: 'cart-quantity'}
  CELL = {css: '.cell'}
  ARTICLE = {xpath: "//a[contains(text(),'Статті')]"}
  DELIVERY = {xpath: "//a[contains(text(),'Доставка')]"}

  IMPLICIT_WAIT = 3

  attr_reader :driver

  def initialize
    @driver = Application.driver
  end

  def search_input_click
    search_input_element.click
  end

  def search_input_clear
    search_input_element.clear
  end

  def search_input_send_keys(search_value)
    search_input_element.send_keys(search_value)
  end

  def search_button_click
    @driver.find_element(SEARCH_BUTTON).click
    sleep(IMPLICIT_WAIT)
  end

  def postponed_click
    @driver.find_element(POSTPONED).click
    sleep(IMPLICIT_WAIT)
  end

  def compare_click
    @driver.find_element(COMPARE).click
    sleep(IMPLICIT_WAIT)
  end

  def compare_quantity
    @driver.find_element(COMPARE_QUANTITY).text.to_i
  end

  def cart_click
    @driver.find_element(CART).click
    sleep(IMPLICIT_WAIT)
    CartProductPage.new
  end

  def cart_quantity
    @driver.find_element(CART_QUANTITY).text.to_i
  end

  def site_logo
    @driver.find_element(LOGO)
  end

  def order_cell
    @driver.find_element(CELL).click
    sleep(IMPLICIT_WAIT)
  end

  def article_click
    @driver.find_element(ARTICLE).click
  end

  def delivery_click
    @driver.find_element(DELIVERY).click
  end

  def search_some_product(search_product)
    search_input_click
    search_input_clear
    search_input_send_keys(search_product)
    search_button_click
    sleep(IMPLICIT_WAIT)
    SearchProductGridPage.new
  end

  def search_category_product(search_category_product)
    search_input_click
    search_input_clear
    search_input_send_keys(search_category_product)
    search_button_click
    sleep(IMPLICIT_WAIT)
    SearchCategoryProductGridPage.new
  end

  def search_firm_product(search_firm_product)
    search_input_click
    search_input_clear
    search_input_send_keys(search_firm_product)
    search_button_click
    sleep(IMPLICIT_WAIT)
    SearchFirmPage.new
  end

  private
  def search_input_element
    @driver.find_element(SEARCH_INPUT)
  end
end
