FINANCIAL = 100

class Parent
  protected
  attr_accessor :financial

  def financial_parent
    @financial = FINANCIAL
  end

end

class Child < Parent
  def output
    financial_parent
  end
end

child = Child.new
puts child.output
