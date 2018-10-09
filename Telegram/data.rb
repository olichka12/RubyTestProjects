TOKEN = '624360729:AAFvAvScsGTQ1biWHrQsE-gAs6XmJ59h8IA'
URL = "http://api.openweathermap.org/data/2.5/weather?q="
API_KEY = "&appid=e26c65c8d284017b52f456669e9d4578&units=Imperial"

WIND_COEFFICIENT = 1.609344
TEMPERATURE_COEFFICIENT = 1.8000
FAHRENHEIT_COEFFICIENT = 32
HOUR_COEFFICIENT = 12

ERROR_WRONG_HTTP_REQUEST = 'Нажаль, інформації незнайдено! Невірний http запит('
ERROR_WRONG_INPUT_CITY = 'Нажаль, незнайдено у цьому місті прогнозу погоди! Спробуй ще раз.'
ERROR_API_KEY = 'Invalid API key'
ERROR_TOKEN_INVALID = 'Невірний токен'
ERROR_INVALID_TIME = 'Некоректний час. Спробуй ще раз!'

HUMIDITY_EMOJI = "\u{1F4A7}"
WIND_EMOJI = "\u{1F4A8}"
TEMPERATURE_EMOJI = "\u{1F321}"
HELLO_EMOJI = "\u{270B}"
HELLO_STR = 'Привіт '
BYE_STR = 'Папа, '
COLON = ':'

MESSAGE_START = '/start'
MESSAGE_WEATHER = '/weather'
MESSAGE_STOP = '/stop'
MESSAGE_SET = '/set'
MESSAGE_NOT_UNDERSTAND = 'Ой, я тебе не розумію. Спробуй ще раз.'
MESSAGE_NOTIFICATION = ' я напишу тобі погоду у місті '
QUESTION_WHICH_CITY = 'У якому саме місті будемо дивитися погоду? (тільки вводь англійською будь ласка)'
QUESTION_WHICH_HOURS = 'На котру годину ставимо нагадування?(ГГ:хх)'

RESPONSE = {coord: 'coord', weather: 'weather', base: 'base', main: 'main', visibility: 'visibility', wind: 'wind',
            clouds: 'clouds', dt: 'dt', sys: 'sys', message: 'message', country: 'country', sunrise: 'sunrise',
            sunset: 'sunset', id: 'id', name: 'name', cod: 'cod'}
RESPONSE_MAIN = {temp: 'temp', pressure: 'pressure', humidity: 'humidity', temp_min: 'temp_min', temp_max: 'temp_max'}
RESPONSE_WIND = {speed: 'speed', deg: 'deg'}
RESPONSE_WEATHER = {id: 'id', main: 'main', description: 'description', icon: 'icon'}
RESPONSE_NOT_FOUND = {cod: 'cod', message: 'message'}
RESPONSE_CODE_NOT_FOUND = '404'

HOUR_TEMPLATE = "%I"
MINUTE_TEMPLATE = "%M"
HOUR_BOUNDARIES = [0, 24]
MINUTE_BOUNDARIES = [0, 10, 60]
