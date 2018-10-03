ASK = 'How are you?'

class PrototypeAsk
  attr_accessor :ask
  def initialize(ask)
    @ask = ask
  end
end


ask_first = PrototypeAsk.new(ASK)
ask_second = ask_first.clone

puts ask_first.object_id
puts ask_second.object_id
puts ask_first.ask
puts ask_second.ask
