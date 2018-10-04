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
      expect(@telegram_bot.conversation(TOKEN_INVALID)).to include?(ERROR_TOKEN_INVALID)
    end
  end
end
