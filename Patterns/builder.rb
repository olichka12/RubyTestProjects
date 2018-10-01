class BreadBuilder

  def create_bread
    bread = Bread.new
  end

  def salt
    Salt.new(none_salt)
  end
end

class Bread

end

class Salt
  def initialize(salt)
    salt = salt
  end
end

class Baker
  def bake(bread_baker)
    bread_baker.salt
    bread_baker.create_bread
  end
end

class RyeBreadBuilder < BreadBuilder
  def salt
    Salt.new(rye_salt)
  end
end

class WheatBreadBuilder < BreadBuilder
  def salt
    Salt.new(wheat_salt)
  end
end


def main
  baker = Baker.new
  rye_bread_builder = RyeBreadBuilder.new
  bread = baker.bake(rye_bread_builder)
end
