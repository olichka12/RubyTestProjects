require 'rspec'
require_relative '../../Telegram/BotProject/telegram_bot'
require_relative '../../Telegram/data'

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
  end

  context 'Convert variables' do
    it 'verifies that the temperature is correctly converted from fahrenheit to celsius' do
      expect(@telegram_bot.temperature_to_celsius(FAHRENHEIT_TESTS_VARIABLES)).to eq CELSIUS_TESTS_VARIABLES
    end

    it 'verifies that the wind is correctly converted to kilometer per hour' do
      expect(@telegram_bot.wind_to_km_hour(WIND_MILE_TESTS_VARIABLES)).to eq (WIND_KILOMETER_TESTS_VARIABLES)
    end
  end
end
