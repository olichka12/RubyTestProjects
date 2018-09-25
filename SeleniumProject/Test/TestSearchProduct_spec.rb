require_relative '../../SeleniumProject/Tools/Application'
require_relative '../../SeleniumProject/Data/Data'
require_relative '../../SeleniumProject/Tools/Pages/HeadComponentPage'
require_relative '../../SeleniumProject/Tools/Pages/SearchProductGridPage'
require_relative '../../SeleniumProject/Tools/Pages/SearchCategoryProductGridPage'
require_relative '../../SeleniumProject/Tools/Pages/SearchFirmPage'
require_relative '../../SeleniumProject/Tools/Pages/CartProductPage'

describe "Selenium tests to site 'https://kvshop.com.ua'" do
  before(:each) do
    @driver = Application.driver
    Application.manage
    Application.get_url(URL)
  end

  after(:each) do
    #Application.quit_application
  end

  it 'First test: if enabled logo' do
    head_component = HeadComponentPage.new
    expect(head_component.found_logo).to be
    #expect(Application.get.found_logo).to be
  end

  it 'Search product and counting amounts product on all pages' do
    search_product = SearchProductGridPage.new
    search_product.search_some_product(PRODUCT)
    expect(search_product.counting_all_products_on_pages).to eql search_product.amount_products
  end

  it 'Sort products by price increase' do
    search_category_product = SearchCategoryProductGridPage.new
    search_category_product.search_category_product(CATEGORY_PRODUCT)
    expect(search_category_product.check_sort_by_price?(CHEAP)).to be
  end

  it 'Sort products by price decrease' do
    search_category_product = SearchCategoryProductGridPage.new
    search_category_product.search_category_product(CATEGORY_PRODUCT)
    expect(search_category_product.check_sort_by_price?(EXPENSIVE)).to be
  end

  it 'Search product by firm' do
    search_firm = SearchFirmPage.new
    search_firm.search_firm_product(FIRM)
    expect(search_firm.check_contains_firm?(FIRM)).to be
  end

  it 'Added product to cart' do
    search_category_product = SearchCategoryProductGridPage.new
    search_category_product.search_category_product(CATEGORY_PRODUCT)
    expect(search_category_product.check_add_to_cart?(PRODUCT_NUMBER)).to be
  end

  it 'Check existing added product in cart' do
    search_category_product = SearchCategoryProductGridPage.new
    search_category_product.search_category_product(CATEGORY_PRODUCT)

    search_category_product.add_to_cart(PRODUCT_NUMBER)

    product_price = search_category_product.product_price(PRODUCT_NUMBER)
    product_name = search_category_product.product_name(PRODUCT_NUMBER)

    search_category_product.cart_click
    cart = CartProductPage.new

    expect(cart.check_existing_product?(product_name)).to be
    expect(cart.check_total_price?(product_price)).to be
  end

  it 'Deleted product from cart' do
    search_category_product = SearchCategoryProductGridPage.new
    search_category_product.search_category_product(CATEGORY_PRODUCT)
    search_category_product.add_to_cart(PRODUCT_NUMBER)
    product_name = search_category_product.product_name(PRODUCT_NUMBER)
    cart_amount = search_category_product.cart_quantity

    search_category_product.cart_click
    cart = CartProductPage.new
    cart.delete_product(product_name)
    expect(cart.cart_quantity).to eq (cart_amount - 1)
  end
end
