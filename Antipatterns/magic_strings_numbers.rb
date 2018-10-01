class Magic
  attr_accessor :string , :number

  def initialize
    @string = 'Hello all! I am magic strings!'
    @numbers = 12
  end

  def change_strings(str = 'How are you?')
    @string = str
  end

  def change_numbers(num = 22)
    @numbers = num
  end
end


magic = Magic.new
magic.change_strings('Hello')
magic.change_numbers(5)
