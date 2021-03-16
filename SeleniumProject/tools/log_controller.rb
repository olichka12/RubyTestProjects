require 'logger'

class LogController
  LOG_SIZE = 512 ** 2
  LOGS_COUNT = 1
  LOG_PATH = File.expand_path('steps_logger.txt')

  def self.instance
    @instance ||= Logger.new(LOG_PATH, LOGS_COUNT, LOG_SIZE)
  end
end
