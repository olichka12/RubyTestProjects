class CartProductPage < HeadComponentPage

  PRODUCT = {xpath: "//p[@class='cart__name_goods  cart__point']//a"}
  TOTAL_PRICE = {class: 'wrap_general-total__num total_cart_amount'}
  #DELETE_PRODUCT = {xpath: "//section[@class='cart_goods cart-item-line']//article//p//a[contains(text(), '#{@product_name}')]/../../../button[@class='cart__delete']"}

  attr_reader :driver

  def initialize
    @driver = Application.driver
  end

  def total_price
    @driver.find_element(TOTAL_PRICE).text.to_i
  end

  def check_existing_product?(product_name)
    product_by_name(product_name)[0].enabled?
  end

  def delete_product(product_name)
    #@product_name = product_name
    #@driver.find_element(DELETE_PRODUCT).click
    @driver.find_element(:xpath, "//section[@class='cart_goods cart-item-line']//article//p//a[contains(text(), '#{product_name}')]/../../../button[@class='cart__delete']").click
    sleep(IMPLICIT_WAIT)
  end

  def check_total_price?(current_price)
    total_price == current_price
  end

  private
  def product_by_name(product_name)
    @driver.find_elements(PRODUCT).select {|name| name.attribute('text') == product_name}
  end
end
