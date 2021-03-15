require_relative 'spec_helper'

describe "Selenium tests to site 'https://kvshop.com.ua'" do
  before(:each) do
    @driver = Application.driver
    Application.maximize_window
    Application.get_url(URL)
  end

  after(:all) do
    Application.quit_application
  end

  after(:each) do |example|
    if example.exception
      Capybara.current_session.save_and_open_screenshot
    end
  end

  it 'verifies that logo is present' do
    expect(Application.head_page.site_logo).to be
  end

  it 'verifies amount of product on all pages of the search result' do
    search_product = Application.head_page.search_some_product(PRODUCT)
    expect(search_product.counting_all_products_on_pages).to eql search_product.amount_products
  end

  it 'verifies that product prices can be sorted increasingly' do
    search_category_product = Application.head_page.search_category_product(CATEGORY_PRODUCT)
    expect(search_category_product.check_sort_by_price?(CHEAP)).to be
  end

  it 'verifies that product prices can be sorted decreasingly' do
    search_category_product = Application.head_page.search_category_product(CATEGORY_PRODUCT)
    expect(search_category_product.check_sort_by_price?(EXPENSIVE)).to be
  end

  it 'verifies that product can be founded by the firm' do
    search_firm = Application.head_page.search_firm_product(FIRM)
    expect(search_firm.check_contains_firm?(FIRM)).to be
  end

  it 'verifies that product can be added to the cart' do
    search_category_product = Application.head_page.search_category_product(CATEGORY_PRODUCT)
    expect(search_category_product.check_add_to_cart?(PRODUCT_NUMBER)).to be
  end

  it 'verifies that added product exists in the cart' do
    cart = Application.head_page.search_category_product(CATEGORY_PRODUCT).add_to_cart(PRODUCT_NUMBER)
    product_name_price = cart.product_name_price(PRODUCT_NUMBER)
    expect(cart.cart_click.check_existing_product?(product_name_price)).to be
  end

  it 'verifies that added product can be deleted from cart' do
    cart = Application.head_page.search_category_product(CATEGORY_PRODUCT).add_to_cart(PRODUCT_NUMBER)
    product_name = cart.product_name(PRODUCT_NUMBER)
    cart_amount = cart.cart_quantity
    expect(cart.cart_click.delete_product(product_name).cart_quantity).to eq (cart_amount - 1)
  end
end
