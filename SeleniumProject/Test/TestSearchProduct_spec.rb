require 'rspec'
require '../Tools/Application'
require_relative '../../SeleniumProject/Data/Data'
require_relative '../../SeleniumProject/Tools/Pages/HeadComponentPage'
require_relative '../../SeleniumProject/Tools/Pages/SearchProductGridPage'
require_relative '../../SeleniumProject/Tools/Pages/SearchCategoryProductGridPage'
require_relative '../../SeleniumProject/Tools/Pages/SearchFirmPage'
require_relative '../../SeleniumProject/Tools/Pages/CartProductPage'

describe "Selenium tests to site 'https://kvshop.com.ua'" do
  before(:each) do
    @driver = Application.get
  end

  after(:each) do
    Application.quit_application
  end

  it 'First test: if enabled logo' do
    head_component = HeadComponentPage.new(@driver)
    expect(head_component.found_logo).to be
    #expect(Application.get.found_logo).to be
  end

  it 'Search product and counting amounts product on all pages' do
    search_product = SearchProductGridPage.new(@driver)
    search_product.search_some_product(PRODUCT)
    expect(search_product.counting_all_products_on_pages).to eql search_product.get_amount_products
  end

  it 'Sort products by price increase' do
    search_category_product = SearchCategoryProductGridPage.new(@driver)
    search_category_product.search_category_product(CATEGORY_PRODUCT)
    expect(search_category_product.check_sort_by_price_cheaper).to be
  end

  it 'Sort products by price decrease' do
    search_category_product = SearchCategoryProductGridPage.new(@driver)
    search_category_product.search_category_product(CATEGORY_PRODUCT)
    expect(search_category_product.check_sort_by_price_expensive).to be
  end

  it 'Search product by firm' do
    search_firm = SearchFirmPage.new(@driver)
    search_firm.search_firm_product(FIRM)
    expect(search_firm.check_contains_firm?(FIRM)).to be
  end

  it 'Added product to cart' do
    search_category_product = SearchCategoryProductGridPage.new(@driver)
    search_category_product.search_category_product(CATEGORY_PRODUCT)
    expect(search_category_product.check_add_to_cart(PRODUCT_NUMBER)).to be
  end


  it 'Check existing added product in cart' do
    search_category_product = SearchCategoryProductGridPage.new(@driver)
    search_category_product.search_category_product(CATEGORY_PRODUCT)

    search_category_product.add_to_cart(PRODUCT_NUMBER)

    product_price = search_category_product.get_product_price(PRODUCT_NUMBER)
    product_name = search_category_product.get_product_name(PRODUCT_NUMBER)

    search_category_product.cart_click
    cart = CartProductPage.new(@driver)

    expect(cart.check_existing_product(product_name)).to be
    expect(cart.get_total_price).to eq product_price
  end

  it 'Deleted product from cart' do
    search_category_product = SearchCategoryProductGridPage.new(@driver)
    search_category_product.search_category_product(CATEGORY_PRODUCT)
    search_category_product.add_to_cart(PRODUCT_NUMBER)
    product_name = search_category_product.get_product_name(PRODUCT_NUMBER)
    cart_amount = search_category_product.get_cart_quantity

    search_category_product.cart_click
    cart = CartProductPage.new(@driver)
    cart.delete_product(product_name)
    expect(cart.get_cart_quantity).to eq (cart_amount - 1)
  end
end
