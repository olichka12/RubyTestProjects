require_relative '../../Telegram/BotProject/telegram_bot'
require_relative '../../Telegram/BotProject/greeting'
require_relative '../../Telegram/BotProject/weather_response'
require_relative '../../Telegram/BotProject/weather_notification'
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
