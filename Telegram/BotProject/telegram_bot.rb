require 'telegram/bot'
require_relative '../../Telegram/data'
require_relative '../../Telegram/BotProject/weather_response'
require_relative '../../Telegram/BotProject/weather_notification'
require_relative '../../Telegram/BotProject/greeting'

class TelegramBot
  attr_accessor :city_default, :weather_message

  def conversation(token)
    begin
      bot = our_bot(token)
      bot.listen do |message|
        case message.text
        when MESSAGE_START
          message_send(bot, message, Greeting.new.hello_message(message.from.first_name))
        when MESSAGE_WEATHER
          message_send(bot, message, QUESTION_WHICH_CITY)
          bot.listen do |message|
            weather_response = WeatherResponse.new
            weather_response.response_json(URL + message.text + API_KEY)
            message_send(bot, message, weather_response.weather_message)
            break
          end
        when MESSAGE_STOP
          message_send(bot, message, Greeting.new.bye_message(message.from.first_name))
        when MESSAGE_SET
          message_send(bot, message, QUESTION_WHICH_CITY)
          bot.listen do |message|
            @city_default = message.text
            WeatherNotification.new.weather_notification_create(bot, message, @city_default)
            break
          end
        else
          message_send(bot, message, MESSAGE_NOT_UNDERSTAND)
        end
      end
    end
  rescue Telegram::Bot::Exceptions::ResponseError => error
    ERROR_TOKEN_INVALID + error.to_s
  end

  def message_send(bot, message, text)
    bot.api.send_message(chat_id: message.chat.id, text: text)
  end

  def our_bot(token)
    Telegram::Bot::Client.run(token) do |bot|
      return  bot
    end
  end
end

# bot = TelegramBot.new
# bot.conversation(TOKEN)
