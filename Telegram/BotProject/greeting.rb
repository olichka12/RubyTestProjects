class Greeting
  def hello_message(user_name)
    "#{HELLO_STR}#{user_name}#{HELLO_EMOJI}\n#{MESSAGE_WEATHER} #{MESSAGE_WEATHER_DESCRIPTION}\n#{MESSAGE_SET} #{MESSAGE_SET_DESCRIPTION}"
  end

  def bye_message(user_name)
    "#{BYE_STR}#{user_name}"
  end
end
