require 'telegram/bot'
require_relative '../../Telegram/data'

class TelegramBot
  attr_accessor :response, :main, :weather, :wind, :weather_message

  def conversation(token)
    begin
      Telegram::Bot::Client.run(token) do |bot|
        bot.listen do |message|
          case message.text
          when MESSAGE_START
            bot.api.send_message(chat_id: message.chat.id, text: hello_message(message.from.first_name))
          when MESSAGE_WEATHER
            response_json(URL)
            bot.api.send_message(chat_id: message.chat.id, text: @weather_message)
          when MESSAGE_STOP
            bot.api.send_message(chat_id: message.chat.id, text:  bye_message(message.from.first_name))
          end
        end
      end
    rescue Telegram::Bot::Exceptions::ResponseError => error
      ERROR_TOKEN_INVALID << error.to_s
    end
  end

  def hello_message(user_name)
    HELLO_STR << user_name << HELLO_EMOJI
  end

  def bye_message(user_name)
    BYE_STR << user_name
  end

  def response_json(url)
    begin
      uri = URI(url)
      response = Net::HTTP.get(uri)
      response.nil? || response.include?(ERROR_API_KEY) ? @response = nil : @response = JSON.parse(response)
    rescue StandardError => error
      @weather_message = ERROR_WRONG_HTTP_REQUEST
      ERROR_WRONG_HTTP_REQUEST << error.to_s
      return
    end
    @response.nil?? @weather_message = ERROR_WRONG_HTTP_REQUEST : response_parse
  end

  def temperature_to_celsius(fahrenheit)
    ((fahrenheit - FAHRENHEIT_COEFFICIENT) / TEMPERATURE_COEFFICIENT).to_i
  end

  def wind_to_km_hour(miles_hour)
    (miles_hour * WIND_COEFFICIENT).to_i
  end

  private
  def response_parse
    @main = @response[RESPONSE[:main]]
    @wind = @response[RESPONSE[:wind]]
    @weather = @response[RESPONSE[:weather]][0]
    @weather_message = "#{city}: #{weather_description}, #{TEMPERATURE_EMOJI} #{temperature}, #{HUMIDITY_EMOJI} #{humidity}, #{WIND_EMOJI} #{wind_speed}"
  end

  def temperature
    temperature_to_celsius(@main[RESPONSE_MAIN[:temp]]).to_s
  end

  def pressure
    @main[RESPONSE_MAIN[:pressure]]
  end

  def humidity
    @main[RESPONSE_MAIN[:humidity]]
  end

  def city
    @response[RESPONSE[:name]]
  end

  def country
    @response[RESPONSE[:country]]
  end

  def wind_speed
    wind_to_km_hour(@wind[RESPONSE_WIND[:speed]]).to_s
  end

  def weather_description
    @weather[RESPONSE_WEATHER[:description]]
  end
end

bot = TelegramBot.new
bot.conversation(TOKEN)
