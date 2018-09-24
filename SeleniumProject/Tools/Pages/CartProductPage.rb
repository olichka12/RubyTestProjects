class CartProductPage < HeadComponentPage

  #PRODUCT = {xpath: "//section[@class='cart_goods cart-item-line']//article//p//a[contains(text(), '#{@product_name}')]"}
  TOTAL_PRICE = {class: 'wrap_general-total__num total_cart_amount'}
  #DELETE_PRODUCT = {xpath: "//section[@class='cart_goods cart-item-line']//article//p//a[contains(text(), '#{@product_name}')]/../../../button[@class='cart__delete']"}

  attr_reader :driver

  def initialize(driver)
    @driver = driver
  end

  def get_total_price
    @driver.find_element(TOTAL_PRICE).text.to_i
  end

  def check_existing_product(product_name)
    #@product_name = product_name
    #@driver.find_element(PRODUCT).enabled?
    @driver.find_element(:xpath, "//section[@class='cart_goods cart-item-line']//article//p//a[contains(text(), '#{product_name}')]").enabled?
  end

  def delete_product(product_name)
    #@product_name = product_name
    #@driver.find_element(DELETE_PRODUCT).click
    @driver.find_element(:xpath, "//section[@class='cart_goods cart-item-line']//article//p//a[contains(text(), '#{product_name}')]/../../../button[@class='cart__delete']").click
    sleep(IMPLICIT_WAIT)
  end

  def check_total_price(current_price)
    get_total_price == current_price
  end
end
