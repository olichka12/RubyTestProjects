class SearchCategoryProductGridPage < HeadComponentPage

  PRODUCT_LIST = {id: 'list'}
  FILTER_PRICE = {class: 'dropdown-toggle btn__sorting'}
  FILTER_PRICE_CHEAPER = {xpath: "//ul[@class='dropdown-menu sorting__menu']//li//a[contains(text(), 'за ціною (спочатку дешеві)')]"}
  FILTER_PRICE_EXPENSIVE = {xpath: "//ul[@class='dropdown-menu sorting__menu']//li//a[contains(text(), 'за ціною (спочатку дорогі)')]"}
  PAGINATION = {class: 'pagination__list'}
  LAST_NUMBER_PAGES = {xpath: "//ul[@class='pagination__list']//li[last()]"}
  #PAGINATION_LIST = {xpath: "//ul[@class='pagination__list']//li//a[contains(text(),'#{@count}')]"}
  #PRODUCT_CATEGORY_PRICE = {xpath: "//div[@class='tab-pane fade in active']/section[#{@product_number}]//section/article//a/../following-sibling::span[@class='prise_description_product-point']"}
  PRODUCT_CATEGORY_AMOUNT = {class: 'product-point'}


  #PRODUCT_CART = {xpath: "//div[@class='tab-pane fade in active']/section[#{@product_number}]//section/article//a/../following-sibling::button[@class='to_cart btn_list_product-point ']"}
  #PRODUCT_PRICE = {xpath: "//div[@class='tab-pane fade in active']/section[#{@product_number}]//section/article//a/../following-sibling::span[@class='prise_description_product-point']"}
  #PRODUCT_NAME = {xpath: "//div[@class='tab-pane fade in active']/section[#{@product_number}]//section/article//a"}
  CART = {class: 'icon-cart'}

  attr_reader :driver

  def initialize(driver)
    @driver = driver
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

  def select_filter_price_cheaper
    filter_price_click
    @driver.find_element(FILTER_PRICE_CHEAPER).click
  end

  def select_filter_price_expensive
    filter_price_click
    @driver.find_element(FILTER_PRICE_EXPENSIVE).click
  end

  def get_last_number_page
    @driver.find_element(LAST_NUMBER_PAGES).text.to_i
  end

  def pagination_list_click(page)
    #@count = page
    #@driver.find_element(PAGINATION_LIST).click
    @driver.find_element(:xpath, "//ul[@class='pagination__list']//li//a[contains(text(),'#{page}')]").click
  end

  def get_product_category_amount
    @driver.find_elements(PRODUCT_CATEGORY_AMOUNT).count
  end

  def get_product_category_price(product_number)
    #@product_number = product_number
    #@driver.find_element(PRODUCT_CATEGORY_PRICE).text.delete("^0-9").to_i
    @driver.find_element(:xpath, "//div[@class='tab-pane fade in active']/section[#{product_number}]//section/article//a/../following-sibling::span[@class='prise_description_product-point']").text.delete("^0-9").to_i
  end

  def add_to_cart(product_number)
    if is_category_product
      #@product_number = product_number
      #@driver.find_element(PRODUCT_CART).click
      @driver.find_element(:xpath, "//div[@class='tab-pane fade in active']/section[#{product_number}]//section/article//a/../following-sibling::button[@class='to_cart btn_list_product-point ']").click
      sleep(IMPLICIT_WAIT)
    end
  end

  def get_product_name(product_number)
    #@product_number = product_number
    #@driver.find_element(PRODUCT_NAME).text
    @driver.find_element(:xpath, "//div[@class='tab-pane fade in active']/section[#{product_number}]//section/article//a").text

  end

  def get_product_price(product_number)
    #@product_number = product_number
    #@driver.find_element(PRODUCT_PRICE).text.delete("^0-9").to_i
    @driver.find_element(:xpath, "//div[@class='tab-pane fade in active']/section[#{product_number}]//section/article//a/../following-sibling::span[@class='prise_description_product-point']").text.delete("^0-9").to_i
  end

  def cart_click
    @driver.find_element(CART).click
    sleep(IMPLICIT_WAIT)
    #CartProductPage.new(@driver)
  end

  def check_add_to_cart(product_number)
    count = get_cart_quantity
    add_to_cart(product_number)
    get_cart_quantity == count+1
  end

  def check_sort_by_price_cheaper
    select_filter_price_cheaper
    if is_category_product
      if is_pagination_list
        with_pagination(:cheap)
      else
        without_pagination(:cheap)
      end
    end
  end

  def check_sort_by_price_expensive
    select_filter_price_expensive
    if is_category_product
      if is_pagination_list
        with_pagination(:expensive)
      else
        without_pagination(:expensive)
      end
    end
  end

  private
  def with_pagination(criterion)
    @check = true
    (1..get_last_number_page).each do |i|
      sleep(IMPLICIT_WAIT)
      @check = false unless without_pagination(criterion)
      pagination_list_click(i+1) if i < get_last_number_page
    end
    @check
  end

  def without_pagination(criterion)
    @check = true
    price = get_product_category_price(1)
    (2..get_product_category_amount).each do |j|
      @check = false unless check_by_criterion(criterion, price, j)
      price = get_product_category_price(j)
    end
    @check
  end

  def check_by_criterion(criterion, price, product_number)
    if criterion == :cheap
      get_product_category_price(product_number) >= price
    elsif criterion == :expensive
      get_product_category_price(product_number) <= price
    end
  end
end
