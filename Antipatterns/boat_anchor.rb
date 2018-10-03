SPEED = 10
SEAT_AMOUNT = 4

class Boat
  attr_accessor :speed, :seat_amount, :firm, :colour

  def initialize(speed, seat_amount, colour)
    @speed = SPEED
    @seat_amount = SEAT_AMOUNT
    @colour = colour
  end

  def firm_boat(firm)
    @firm = firm
  end

  # def description(description)
  #   description
  # end
  #

  # def colour(colour)
  #   @colour = colour
  # end

end
