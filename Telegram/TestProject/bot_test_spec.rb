require_relative '../../Telegram/TestProject/spec_helper'

describe 'Testing Telegram Bot' do
  context 'Greeting' do
    before(:each) do
      @greeting = Greeting.new
    end

    it 'verifies that bot send message hello' do
      expect(@greeting.hello_message(USER_NAME)).to include(HELLO_STR << USER_NAME << HELLO_EMOJI)
    end

    it 'verifies that bot send message bye' do
      expect(@greeting.bye_message(USER_NAME)).to eq BYE_STR << USER_NAME
    end
  end

  context 'Telegram bot conversation' do
    before(:each) do
      @telegram_bot = TelegramBot.new
    end

    it 'verifies thу error message that the token is invalid' do
      expect(@telegram_bot.conversation(TOKEN_INVALID)).to include(ERROR_TOKEN_INVALID)
    end
  end

  context 'Weather response' do
    before(:each) do
      @weather_response = WeatherResponse.new
    end

    it 'verifies response with empty URL' do
      @weather_response.response_json(URL_EMPTY)
      expect(@weather_response.weather_message).to eq ERROR_WRONG_HTTP_REQUEST
    end

    it 'verifies response with integer URL' do
      @weather_response.response_json(URL_INTEGER)
      expect(@weather_response.weather_message).to eq ERROR_WRONG_HTTP_REQUEST
    end

    it 'verifies response with URL which without key' do
      @weather_response.response_json(URL_WITHOUT_KEY)
      expect(@weather_response.weather_message).to eq ERROR_WRONG_HTTP_REQUEST
    end

    it 'verifies response with correct URL' do
      @weather_response.response_json(URL_CONSTANT)
      expect(@weather_response.response[RESPONSE[:main]]).to eq RESPONSE_MAIN_CONSTANT
    end

    it 'verifies response about main information with correct URL' do
      @weather_response.response_json(URL_CONSTANT)
      expect(@weather_response.main).to eq RESPONSE_MAIN_CONSTANT
    end

    it 'verifies response about wind with correct URL' do
      @weather_response.response_json(URL_CONSTANT)
      expect(@weather_response.wind).to eq RESPONSE_WIND_CONSTANT
    end

    it 'verifies response about weather with correct URL' do
      @weather_response.response_json(URL_CONSTANT)
      expect(@weather_response.weather).to eq RESPONSE_WEATHER_CONSTANT
    end

    it 'verifies weather message with correct URL' do
      @weather_response.response_json(URL_CONSTANT)
      expect(@weather_response.weather_message).to eq WEATHER_MESSAGE_CONSTANT
    end

    it 'verifies weather message with do not full URL' do
      @weather_response.response_json(URL_NOT_FULL)
      expect(@weather_response.weather_message).to eq ERROR_WRONG_HTTP_REQUEST
    end

    it 'verifies weather message with wrong city name in URL' do
      @weather_response.response_json(URL_WRONG_CITY)
      expect(@weather_response.weather_message).to eq ERROR_WRONG_INPUT_CITY
    end

    it 'verifies that the temperature is correctly converted from fahrenheit to celsius' do
      expect(@weather_response.temperature_to_celsius(FAHRENHEIT_TESTS_VARIABLES)).to eq CELSIUS_TESTS_VARIABLES
    end

    it 'verifies that the wind is correctly converted to kilometer per hour' do
      expect(@weather_response.wind_to_km_hour(WIND_MILE_TESTS_VARIABLES)).to eq (WIND_KILOMETER_TESTS_VARIABLES)
    end
  end

  context 'Check variables' do
    before(:each) do
      @weather_notification = WeatherNotification.new
    end

    it 'verifies that 00 hour is in boundary' do
      expect(@weather_notification.check_hour(HOUR_BOUNDARIES[0])).to be
    end

    it 'verifies that 24 hour is not in boundary' do
      expect(@weather_notification.check_hour(HOUR_BOUNDARIES[1])).not_to be
    end

    it 'verifies that letters instead of an hour do not in boundary' do
      expect(@weather_notification.check_hour(HELLO_STR)).not_to be
    end

    it 'verifies that 00 minutes is in boundary' do
      expect(@weather_notification.check_minute(MINUTE_BOUNDARIES[0])).to be
    end

    it 'verifies that 60 minutes is not in boundary' do
      expect(@weather_notification.check_minute(MINUTE_BOUNDARIES[2])).not_to be
    end

    it 'verifies that letters instead of an minute do not in boundary' do
      expect(@weather_notification.check_minute(HELLO_STR)).not_to be
    end

    it 'verifies that time now equals the inputs time' do
      expect(@weather_notification.check_time_now(Time.now.strftime(HOUR_TEMPLATE).to_i + HOUR_COEFFICIENT, Time.now.strftime(MINUTE_TEMPLATE).to_i)).to be
    end
  end
end
