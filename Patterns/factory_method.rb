class Mechanism
  def type_wheel(radius, weight, length, season = :all)
  end

  def type_engine(type = :manual)
  end

  def mechanism_create

  end
end


class Car < Mechanism
  def type_wheel(radius, weight, length, season)
    super(radius, weight, length, season)
  end

  def type_engine(type = :patrol)
    super(:patrol)
  end

  def mechanism_create
    CarCreate.new
  end
end

class Bus < Mechanism
  def type_wheel(radius, weight, length, season)
    super(radius, weight, length, season)
  end

  def type_engine(type = :diesel)
    super(:diesel)
  end

  def mechanism_create
    BusCreate.new
  end
end

class Bicycle < Mechanism
  def type_wheel(radius, weight, length, season)
    super(radius, weight, length, season)
  end

  def type_engine
    super
  end

  def mechanism_create
    BicycleCreate.new
  end
end


class CarCreate
  def car

  end
end

class BusCreate
  def bus

  end
end

class BicycleCreate
  def bicycle

  end
end


mechanism = Car.new
car_create = mechanism.mechanism_create
