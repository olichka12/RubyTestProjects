require_relative '../../Telegram/BotProject/weather_response'

class WeatherNotification < WeatherResponse
  attr_accessor :city_default, :telegram_bot

  def check_time_now(hour, minute)
    Time.now.strftime(HOUR_TEMPLATE).to_i + HOUR_COEFFICIENT == hour.to_i && Time.now.strftime(MINUTE_TEMPLATE).to_i == minute.to_i ? true : false
  end

  def check_hour(hour)
    if is_numeric?(hour)
      (hour.to_i >= HOUR_BOUNDARIES[0] && hour.to_i < HOUR_BOUNDARIES[1]) ? true : false
    else
      false
    end
  end

  def check_minute(minute)
    if is_numeric?(minute)
      (minute.to_i >= MINUTE_BOUNDARIES[0] && minute.to_i < MINUTE_BOUNDARIES[2]) ? true : false
    else
      false
    end
  end

  def weather_notification_create(bot, message, city_default)
    @city_default = city_default
    notification_set(bot, message)
  end

  private
  def notification_set(bot, message)
    response_json("#{URL}#{@city_default}#{API_KEY}")
    if @weather_message.include?("#{@city_default}")
      @telegram_bot = t_bot
      @telegram_bot.message_send(bot, message, QUESTION_WHICH_HOURS)
      bot.listen do |message|
        weather_notification(bot, message, message.text)
        break
      end
    else
      bot.api.send_message(chat_id: message.chat.id, text: ERROR_WRONG_INPUT_CITY)
    end
  end

  def weather_notification(bot, message, hours_minutes)
    check_hour(hours_minutes[/\d+/]) && check_minute(hours_minutes[/\d+$/]) ? background_run(message, hours_minutes[/\d+/], hours_minutes[/\d+$/], @telegram_bot.our_bot(TOKEN)) : @telegram_bot.message_send(bot, message, ERROR_INVALID_TIME)
  end

  def background_run(message, hour, minute, bot)
    fork do
      @telegram_bot.message_send(bot, message, "#{hour}#{COLON}#{minute} #{MESSAGE_NOTIFICATION} #{@city_default}")
      sleep(MINUTE_BOUNDARIES[1]) until check_time_now(hour, minute)
      notification_send(message, bot)
    end
  end

  def notification_send(message, bot)
    response_json("#{URL}#{@city_default}#{API_KEY}")
    @telegram_bot.message_send(bot, message, @weather_message)
  end

  def is_numeric?(str)
    str.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end

  def t_bot
    TelegramBot.new
  end
end
