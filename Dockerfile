FROM ruby:2.5.1
COPY . ./
RUN gem install bundler && bundle
CMD ruby Telegram/BotProject/telegram_bot.rb