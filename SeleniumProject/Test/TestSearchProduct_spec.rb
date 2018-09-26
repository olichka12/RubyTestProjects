require_relative 'spec_helper'

describe "Selenium tests to site 'https://kvshop.com.ua'" do
  before(:each) do
    @driver = Application.driver
    Application.manage
    Application.get_url(URL)
  end

  after(:all) do
    Application.quit_application
  end

  it 'First test: if enabled logo' do
    expect(Application.get.found_logo).to be
  end

  it 'Search product and counting amounts product on all pages' do
    search_product = Application.get.search_some_product(PRODUCT)
    expect(search_product.counting_all_products_on_pages).to eql search_product.amount_products
  end

  it 'Sort products by price increase' do
    search_category_product = Application.get.search_category_product(CATEGORY_PRODUCT)
    expect(search_category_product.check_sort_by_price?(CHEAP)).to be
  end

  it 'Sort products by price decrease' do
    search_category_product = Application.get.search_category_product(CATEGORY_PRODUCT)
    expect(search_category_product.check_sort_by_price?(EXPENSIVE)).to be
  end

  it 'Search product by firm' do
    search_firm = Application.get.search_firm_product(FIRM)
    expect(search_firm.check_contains_firm?(FIRM)).to be
  end

  it 'Added product to cart' do
    search_category_product = Application.get.search_category_product(CATEGORY_PRODUCT)
    expect(search_category_product.check_add_to_cart?(PRODUCT_NUMBER)).to be
  end

  it 'Check existing added product in cart' do
    cart = Application.get.search_category_product(CATEGORY_PRODUCT).add_to_cart(PRODUCT_NUMBER)
    product_name_price = cart.product_name_price(PRODUCT_NUMBER)
    expect(cart.cart_click.check_existing_product?(product_name_price)).to be
  end

  it 'Deleted product from cart' do
    cart = Application.get.search_category_product(CATEGORY_PRODUCT).add_to_cart(PRODUCT_NUMBER)
    product_name = cart.product_name(PRODUCT_NUMBER)
    cart_amount = cart.cart_quantity
    expect(cart.cart_click.delete_product(product_name).cart_quantity).to eq (cart_amount - 1)
  end
end
