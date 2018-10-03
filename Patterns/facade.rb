WHEEL_CAR = 17, 195, 85
WHEEL_BUS = 14, 170, 60
ENGINE_TYPE = %w(petrol diesel)
ENGINE_VALUE = 1.9, 2.5
SEATS = 5, 3, 6, 9

class Wheel
  def initialize(parameters)
  end
end

class Engine
  def initialize(type, volume)
  end
end

class Seats
  def initialize(amount)
  end
end

class Accessories
  def car_accessories
  end

  def bus_accessories
  end
end

class Model
  def car_model
  end

  def bus_model
  end
end

class Facade
  def create_bus
    Wheel.new(WHEEL_CAR)
    Engine.new(ENGINE_TYPE[1], ENGINE_TYPE[0])
    Seats.new(SEATS[3])
    Accessories.new.bus_accessories
    Model.new.bus_model
  end

  def create_car
    Wheel.new(WHEEL_BUS)
    Engine.new(ENGINE_TYPE[0], ENGINE_TYPE[1])
    Seats.new(SEATS[0])
    Accessories.new.car_accessories
    Model.new.car_model
  end
end

facade = Facade.new
facade.create_bus
facade.create_car
