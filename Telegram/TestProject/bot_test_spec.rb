require 'rspec'
require_relative '../../Telegram/BotProject/telegram_bot'
require_relative '../../Telegram/data'

TOKEN_INVALID = '624360729:AAFvAvScsGTQ1biWH'
URL_CONSTANT = "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22"
URL_NOT_FULL = "http://api.openweathermap.org/data/2.5/weather?q=Lviv"
URL_WRONG_CITY = "http://api.openweathermap.org/data/2.5/weather?q=WrongCity&appid=e26c65c8d284017b52f456669e9d4578&units=Imperial"
URL_WITHOUT_KEY = "https://samples.openweathermap.org/data/2.5/weather?q=Lviv"
URL_EMPTY = ''
URL_INTEGER = 3
USER_NAME = 'Olha'
RESPONSE_MAIN_CONSTANT = {"temp" => 280.32, "pressure" => 1012, "humidity" => 81, "temp_min" => 279.15, "temp_max" => 281.15}
RESPONSE_WIND_CONSTANT = {"speed" => 4.1, "deg" => 80}
RESPONSE_WEATHER_CONSTANT = {"id" => 300, "main" => "Drizzle", "description" => "light intensity drizzle", "icon"=> "09d"}

FAHRENHEIT_TESTS_VARIABLES = 100
CELSIUS_TESTS_VARIABLES = 37
WIND_MILE_TESTS_VARIABLES = 20
WIND_KILOMETER_TESTS_VARIABLES = 32

WEATHER_MESSAGE_CONSTANT = "London: light intensity drizzle, \u{1F321} 137, \u{1F4A7} 81, \u{1F4A8} 6"

describe 'Testing Telegram Bot' do
  before(:each) do
    @telegram_bot = TelegramBot.new
  end

  context 'Start' do
    it 'verifies that bot send message hello' do
      expect(@telegram_bot.hello_message(USER_NAME)).to eq HELLO_STR << USER_NAME << HELLO_EMOJI
    end
  end

  context 'Stop' do
    it 'verifies that bot send message bye' do
      expect(@telegram_bot.bye_message(USER_NAME)).to eq BYE_STR << USER_NAME
    end
  end

  context 'Conversation' do
    it 'verifies thу error message that the token is invalid' do
      expect(@telegram_bot.conversation(TOKEN_INVALID)).to include(ERROR_TOKEN_INVALID)
    end
  end

  context 'Response' do
    it 'verifies response with empty URL' do
      @telegram_bot.response_json(URL_EMPTY)
      expect(@telegram_bot.weather_message).to eq ERROR_WRONG_HTTP_REQUEST
    end

    it 'verifies response with integer URL' do
      @telegram_bot.response_json(URL_INTEGER)
      expect(@telegram_bot.weather_message).to eq ERROR_WRONG_HTTP_REQUEST
    end

    it 'verifies response with URL which without key' do
      @telegram_bot.response_json(URL_WITHOUT_KEY)
      expect(@telegram_bot.weather_message).to eq ERROR_WRONG_HTTP_REQUEST
    end

    it 'verifies response with correct URL' do
      @telegram_bot.response_json(URL_CONSTANT)
      expect(@telegram_bot.response[RESPONSE[:main]]).to eq RESPONSE_MAIN_CONSTANT
    end

    it 'verifies response about main information with correct URL' do
      @telegram_bot.response_json(URL_CONSTANT)
      expect(@telegram_bot.main).to eq RESPONSE_MAIN_CONSTANT
    end

    it 'verifies response about wind with correct URL' do
      @telegram_bot.response_json(URL_CONSTANT)
      expect(@telegram_bot.wind).to eq RESPONSE_WIND_CONSTANT
    end

    it 'verifies response about weather with correct URL' do
      @telegram_bot.response_json(URL_CONSTANT)
      expect(@telegram_bot.weather).to eq RESPONSE_WEATHER_CONSTANT
    end

    it 'verifies weather message with correct URL' do
      @telegram_bot.response_json(URL_CONSTANT)
      expect(@telegram_bot.weather_message).to eq WEATHER_MESSAGE_CONSTANT
    end

    it 'verifies weather message with do not full URL' do
      @telegram_bot.response_json(URL_NOT_FULL)
      expect(@telegram_bot.weather_message).to eq ERROR_WRONG_HTTP_REQUEST
    end

    it 'verifies weather message with wrong city name in URL' do
      @telegram_bot.response_json(URL_WRONG_CITY)
      expect(@telegram_bot.weather_message).to eq ERROR_WRONG_INPUT_CITY
    end
  end

  context 'Convert variables' do
    it 'verifies that the temperature is correctly converted from fahrenheit to celsius' do
      expect(@telegram_bot.temperature_to_celsius(FAHRENHEIT_TESTS_VARIABLES)).to eq CELSIUS_TESTS_VARIABLES
    end

    it 'verifies that the wind is correctly converted to kilometer per hour' do
      expect(@telegram_bot.wind_to_km_hour(WIND_MILE_TESTS_VARIABLES)).to eq (WIND_KILOMETER_TESTS_VARIABLES)
    end
  end

  context 'Check variables' do
    it 'verifies that 00 hour is in boundary' do
      expect(@telegram_bot.check_hour(HOUR_BOUNDARIES[0])).to be
    end

    it 'verifies that 24 hour is not in boundary' do
      expect(@telegram_bot.check_hour(HOUR_BOUNDARIES[1])).not_to be
    end

    it 'verifies that 00 minutes is in boundary' do
      expect(@telegram_bot.check_minute(MINUTE_BOUNDARIES[0])).to be
    end

    it 'verifies that 60 minutes is not in boundary' do
      expect(@telegram_bot.check_minute(MINUTE_BOUNDARIES[2])).not_to be
    end

    it 'verifies that time now equals the inputs time' do
      expect(@telegram_bot.check_time_now(Time.now.strftime(HOUR_TEMPLATE).to_i + HOUR_COEFFICIENT, Time.now.strftime(MINUTE_TEMPLATE).to_i)).to be
    end
  end
end
