require 'json'
require_relative '../../Mail/data'
require_relative '../../Mail/MailProject/mail_box'
require 'pry'

class MailJSON
  attr_accessor :login, :hash, :box, :all_count, :unread_count, :read_count, :subject, :from, :date, :body

  def initialize
    @login = false
  end

  def write_mail_json(user_name, user_password)
    @box = MailBox.new
    @box.login(user_name, user_password)
    @login = @box.is_login
    mail_to_json if @login
  end

  def count_mail_json
    read_file
    @all_count = @hash[LETTER_STATE[2].to_s]
    @all_count = @all_count[JSON_PARSE[0].to_s].to_i
    @unread_count = @hash[LETTER_STATE[0].to_s]
    @unread_count = @unread_count[JSON_PARSE[0].to_s].to_i
    @read_count = @hash[LETTER_STATE[1].to_s]
    @read_count = @read_count[JSON_PARSE[0].to_s].to_i
  end

  def subject_mail_json(letter_state)
    read_file
    @subject = @hash[letter_state.to_s]
    @subject = @subject[JSON_PARSE[1].to_s][0]
  end

  def letter_json(letter_state, number)
    read_file
    @subject = @hash[letter_state.to_s]
    @subject = @subject[JSON_PARSE[1].to_s][0]
    @from = @hash[letter_state.to_s]
    @from = @from[JSON_PARSE[1].to_s][1]
    @date = @hash[letter_state.to_s]
    @date = @date[JSON_PARSE[1].to_s][2]
    @body = @hash[letter_state.to_s]
    @body = @body[JSON_PARSE[1].to_s][3]
  end

  private
  def mail_to_json
    letter = {LETTER_STATE[2] => create_letter_information(LETTER_STATE[2]),
              LETTER_STATE[0] => create_letter_information(LETTER_STATE[0]),
              LETTER_STATE[1] => create_letter_information(LETTER_STATE[1])
              }
    write_letter_file(letter)
  end

  def create_letter_information(letter_state)
    @box.letter_information(letter_state,0)
    {JSON_PARSE[0] => @box.letter_count(letter_state), JSON_PARSE[1] => [@box.subject, @box.from, @box.date, @box.body]}
  end

  def write_letter_file(letter)
    File.open(JSON_FILE_NAME, JSON_FILE_ACCESS) do |line|
      line.write(letter.to_json)
    end
  end

  def read_file
    @hash = JSON.parse(File.read(JSON_FILE_NAME))
  end
end
