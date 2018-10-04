#API_KEY = 'e26c65c8d284017b52f456669e9d4578'
TOKEN = '624360729:AAFvAvScsGTQ1biWHrQsE-gAs6XmJ59h8IA'
TOKEN_INVALID = '624360729:AAFvAvScsGTQ1biWH'
URL = "http://api.openweathermap.org/data/2.5/weather?q=Lviv&appid=e26c65c8d284017b52f456669e9d4578&units=Imperial"
URL_CONSTANT = "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22"
RESPONSE_MAIN_CONSTANT = {temp: 280.32, pressure: 1012, humidity: 81, temp_min: 279.15, temp_max:281.15}
RESPONSE_WIND_CONSTANT = {speed: 4.1, deg: 80}
RESPONSE_WEATHER_CONSTANT = [{id: 300, main: "Drizzle", description: "light intensity drizzle", icon: "09d"}]
URL_WITHOUT_KEY = "https://samples.openweathermap.org/data/2.5/weather?q=Lviv"
URL_EMPTY = ''
URL_INTEGER = 3
USER_NAME = 'Olha'

WIND_COEFFICIENT = 1.609344
TEMPERATURE_COEFFICIENT = 1.8000
FAHRENHEIT_COEFFICIENT = 32

ERROR_WRONG_HTTP_REQUEST = 'Нажаль, інформації незнайдено! Невірний http запит('
ERROR_API_KEY = 'Invalid API key'
ERROR_TOKEN_INVALID = 'Невірний токен'

HUMIDITY_EMOJI = "\u{1F4A7}"
WIND_EMOJI = "\u{1F4A8}"
TEMPERATURE_EMOJI = "\u{1F321}"
HELLO_EMOJI = "\u{270B}"
HELLO_STR = 'Привіт '
BYE_STR = 'Папа, '

MESSAGE_START = '/start'
MESSAGE_WEATHER = '/weather'
MESSAGE_STOP = '/stop'

RESPONSE = {coord: 'coord', weather: 'weather', base: 'base', main: 'main', visibility: 'visibility', wind: 'wind',
            clouds: 'clouds', dt: 'dt', sys: 'sys', message: 'message', country: 'country', sunrise: 'sunrise',
            sunset: 'sunset', id: 'id', name: 'name', cod: 'cod'}
RESPONSE_MAIN = {temp: 'temp', pressure: 'pressure', humidity: 'humidity', temp_min: 'temp_min', temp_max: 'temp_max'}
RESPONSE_WIND = {speed: 'speed', deg: 'deg'}
RESPONSE_WEATHER = {id: 'id', main: 'main', description: 'description', icon: 'icon'}

WEATHER_MESSAGE_CONSTANT = "London: light intensity drizzle, \u{1F321} 137, \u{1F4A7} 81, \u{1F4A8} 4.1"