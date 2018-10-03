PRICE = 500
SPRING_SALE_AMOUNT = 100
SUMMER_SALE_AMOUNT = 200
SPRING_SALE = 'Spring Sale'
SUMMER_SALE = 'Summer Sale'

class Price
  attr_reader :price
  def initialize
    @price = PRICE
  end
end

class Decorator
  def initialize(item)
    @item = item
  end
end

class SpringSale < Decorator
  def price
    @item.price - SPRING_SALE_AMOUNT
  end

  def description
    SPRING_SALE
  end
end

class SummerSale < Decorator
  def price
    @item.price - SUMMER_SALE_AMOUNT
  end

  def description
    SUMMER_SALE
  end
end

price = Price.new
spring_sale = SpringSale.new(price)
puts spring_sale.price
puts spring_sale.description

masterpiece_item = SummerSale.new(price)
puts masterpiece_item.price
puts masterpiece_item.description
