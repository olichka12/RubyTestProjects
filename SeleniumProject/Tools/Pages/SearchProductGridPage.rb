class SearchProductGridPage < HeadComponentPage
  DROPDOWN = {class: 'fa fa-angle-down drop_caret'}
  DROPDOWN_CATEGORY = {class: 'item__drop-category'}
  SHOW_COUNT = {xpath: "//div[@class='quantity']"}
  AMOUNT_ALL_PRODUCTS = {xpath: "//div[@class = 'quantity']"}
  AMOUNT_PRODUCTS_PAGE = {xpath: "//section[contains(@class,'product-point_grid col-lg-3 col-md-3 col-sm-3 col-xs-3 ')]"}
  LAST_NUMBER_PAGES = {xpath: "//ul[@class='pagination__list']//li[last()]"}
  #PAGINATION_LIST =
  PRODUCT_GRID = {id: 'grid'}

  attr_accessor :count
  attr_reader :driver

  def initialize
    @driver = Application.driver
  end

  def dropdown_category(dropdown_categ)
    @driver.find_elements(DROPDOWN_CATEGORY).select {|category| category.attribute('text') == dropdown_categ}
  end

  def dropdown_count_click(dropdown_categ)
    @driver.find_element(DROPDOWN).click
    sleep(IMPLICIT_WAIT)
    dropdown_category(dropdown_categ)[0].click
    sleep(IMPLICIT_WAIT)
    #SearchProductGridPage.new(driver)
  end

  def amount_products
    @driver.find_element(AMOUNT_ALL_PRODUCTS).text.strip.match(/(?:з )[0-9]+/).to_s.delete("^0-9").to_i
  end

  def amount_products_on_page
    @driver.find_elements(AMOUNT_PRODUCTS_PAGE).count
  end

  def last_number_page
    @driver.find_element(LAST_NUMBER_PAGES).text.to_i
  end

  def pagination_list_click(page)
    #@count = page
    #@driver.find_element(PAGINATION_LIST).click
    @driver.find_element(:xpath, "//ul[@class='pagination__list']//li//a[contains(text(),'#{page}')]").click
  end

  def is_product
    @driver.find_element(PRODUCT_GRID).enabled?
  end

  def counting_all_products_on_pages
    if is_product
      @amount_products = amount_products_on_page
      if last_number_page > 1
        (2..last_number_page).each do |i|
          pagination_list_click(i)
          sleep(IMPLICIT_WAIT)
          @amount_products += amount_products_on_page
        end
      end
      @amount_products
    end
  end
end
