class Greeting
  def hello_message(user_name)
    HELLO_STR + user_name + HELLO_EMOJI
  end

  def bye_message(user_name)
    BYE_STR + user_name
  end
end
