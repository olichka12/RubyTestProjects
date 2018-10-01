WATER_STATE = %w(solid gas liquid)

class Water
  def state_output
  end
end

class SolidWater < Water
  def state_output
    WATER_STATE[0]
  end
end

class GasWater < Water
  def state_output
    WATER_STATE[1]
  end
end

class LiquidWater < Water
  def state_output
    WATER_STATE[2]
  end
end

class WaterProcess
  attr_accessor :water_state

  def initialize(water_state)
    @water_state = water_state
  end

  def result
    @water_state.state_output
  end
end

water = WaterProcess.new(SolidWater.new)
water.result
water = WaterProcess.new(GasWater.new)
water.result
