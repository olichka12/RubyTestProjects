class SearchCategoryProductGridPage < HeadComponentPage

  PRODUCT_LIST = {id: 'list'}
  FILTER_PRICE = {class: 'dropdown-toggle btn__sorting'}
  FILTER_PRICE_CHEAPER = {xpath: "//ul[@class='dropdown-menu sorting__menu']//li//a[contains(text(), 'за ціною (спочатку дешеві)')]"}
  FILTER_PRICE_EXPENSIVE = {xpath: "//ul[@class='dropdown-menu sorting__menu']//li//a[contains(text(), 'за ціною (спочатку дорогі)')]"}
  PAGINATION = {class: 'pagination__list'}
  LAST_NUMBER_PAGES = {xpath: "//ul[@class='pagination__list']//li[last()]"}
  #PAGINATION_LIST =
  # PAGINATION_LIST =
  PRODUCT_CATEGORY_AMOUNT = {class: 'product-point'}

  PAGINATION_LIST = {class: 'pagination__link'}
  PRODUCT_CART = {class: 'to_cart btn_list_product-point '}
  PRODUCT_PRICE = {class: 'prise_description_product-point'}
  PRODUCT_NAME = {xpath: "//article[@class='caption_description_product-point']//a"}
  CART = {class: 'icon-cart'}

  attr_reader :driver

  def initialize
    @driver = Application.driver
  end

  def is_category_product
    @driver.find_element(PRODUCT_LIST).enabled?
  end

  def is_pagination_list
    @driver.find_element(PAGINATION).enabled?
  end

  def filter_price_click
    @driver.find_element(FILTER_PRICE).click
    sleep(IMPLICIT_WAIT)
  end

  def select_filter_price(cheap_or_expensive)
    filter_price_click
    cheap_or_expensive == :cheap ? @driver.find_element(FILTER_PRICE_CHEAPER).click : @driver.find_element(FILTER_PRICE_EXPENSIVE).click
    sleep(IMPLICIT_WAIT)
  end

  def last_number_page
    @driver.find_element(LAST_NUMBER_PAGES).text.to_i
  end

  def pagination_to_page(page)
    @driver.find_elements(PAGINATION_LIST).select {|pagination| pagination.attribute('text') == "'#{page}'"}
  end

  def pagination_list_click(page)
    # @driver.find_element(tag_name: 'a').select { |el| el.attribute('title') == search_asd }

    #pagination_to_page(page)[0].click


    @driver.find_element(:xpath, "//ul[@class='pagination__list']//a[contains(text(),'#{page}')]").click
    sleep(IMPLICIT_WAIT)
  end

  def product_category_amount
    @driver.find_elements(PRODUCT_CATEGORY_AMOUNT).count
  end

  def add_to_cart(product_number)
    if is_category_product
      @driver.find_elements(PRODUCT_CART)[product_number - 1].click
      sleep(IMPLICIT_WAIT)
    end
  end

  def product_name(product_number)
    @driver.find_elements(PRODUCT_NAME)[product_number - 1].text
  end

  def product_price(product_number)
    @driver.find_elements(PRODUCT_PRICE)[product_number - 1].text.delete("^0-9").to_i
  end

  def cart_click
    @driver.find_element(CART).click
    sleep(IMPLICIT_WAIT)
    #CartProductPage.new(@driver)
  end

  def check_add_to_cart?(product_number)
    product_count_primary = cart_quantity
    add_to_cart(product_number)
    cart_quantity == product_count_primary + 1
  end

  def check_sort_by_price?(cheap_or_expensive)
    select_filter_price(cheap_or_expensive)
    is_category_product ? pagination_I_need(cheap_or_expensive) : nil
  end

  private
  def pagination_I_need(criterion)
    is_pagination_list ? with_pagination(criterion) : without_pagination(criterion)
  end

  def with_pagination(criterion)
    (1..last_number_page).each do |i|
      sleep(IMPLICIT_WAIT)
      return  false unless without_pagination(criterion)
      pagination_list_click(i+1) if i < last_number_page
    end
    true
  end

  def without_pagination(criterion)
    price = product_price(1)
    (2..product_category_amount).each do |j|
      return false unless check_by_criterion(criterion, price, j)
      price = product_price(j)
    end
    true
  end

  def check_by_criterion(criterion, price, product_number)
    if criterion == :cheap
      product_price(product_number) >= price
    elsif criterion == :expensive
      product_price(product_number) <= price
    end
  end
end
