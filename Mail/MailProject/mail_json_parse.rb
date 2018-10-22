require 'json'
require_relative '../../Mail/data'
require_relative '../../Mail/MailProject/mail_box'

class MailJSON
  attr_accessor :login, :hash, :box, :all_count, :unread_count, :read_count, :subject, :from, :date, :body, :unread_letter, :read_letter

  def initialize
    @login = false
    @hash = {}
    @unread_letter = {}
    @read_letter = {}
  end

  def write_mail_json(user_name, user_password)
    write_file(JSON_FILE_NAME, EMPTY_STRING)
    @box = MailBox.new
    @box.login(user_name, user_password)
    @login = @box.is_login
    mail_to_json if @login
  end

  def count_mail_json
    @hash = read_file(JSON_FILE_NAME)
    @all_count = @hash[LETTER_STATE[2].to_s]
    @all_count = @all_count[JSON_PARSE[0].to_s].to_i
    @unread_count = @hash[LETTER_STATE[0].to_s]
    @unread_count = @unread_count[JSON_PARSE[0].to_s].to_i
    @read_count = @hash[LETTER_STATE[1].to_s]
    @read_count = @read_count[JSON_PARSE[0].to_s].to_i
  end

  def subject_mail_json(letter_state)
    @hash = read_file(JSON_FILE_NAME)
    @subject = @hash[letter_state.to_s]
    @subject = @subject[JSON_PARSE[1].to_s][0]
  end

  def letter_json(letter_state, number)
    @hash = read_file(JSON_FILE_NAME)
    @subject = @hash[letter_state.to_s]
    @subject = @subject[JSON_PARSE[1].to_s][0]
    @from = @hash[letter_state.to_s]
    @from = @from[JSON_PARSE[1].to_s][1]
    @date = @hash[letter_state.to_s]
    @date = @date[JSON_PARSE[1].to_s][2]
    @body = @hash[letter_state.to_s]
    @body = @body[JSON_PARSE[1].to_s][3]
    read_letter(number) if letter_state == LETTER_STATE[0].to_s
  end

  private
  def read_letter(number)
    @hash = read_file(JSON_FILE_NAME)
    @unread_letter = @hash[LETTER_STATE[0].to_s]
    @read_letter = @hash[LETTER_STATE[1].to_s]

    create_read_letter(number)
    delete_unread_letter(number)

    letter = {LETTER_STATE[2] => @hash[LETTER_STATE[2].to_s],
              LETTER_STATE[0] => @unread_letter,
              LETTER_STATE[1] => @read_letter
             }
    write_file(JSON_FILE_NAME, letter)
  end

  def delete_unread_letter(number)
    @unread_letter[JSON_PARSE[0].to_s] = @unread_letter[JSON_PARSE[0].to_s] - 1
    @unread_letter[JSON_PARSE[1].to_s][0].delete(number.to_s)
    @unread_letter[JSON_PARSE[1].to_s][1].delete(number.to_s)
    @unread_letter[JSON_PARSE[1].to_s][2].delete(number.to_s)
    @unread_letter[JSON_PARSE[1].to_s][3].delete(number.to_s)
    @unread_letter[JSON_PARSE[1].to_s][4].delete(number.to_s)
  end

  def create_read_letter(number)
    read_subject = @subject[number.to_s]
    read_from = @from[number.to_s]
    read_date = @date[number.to_s]
    read_body = @body[number.to_s]
    uid = @unread_letter[JSON_PARSE[1].to_s][4]
    read_uid = uid[number.to_s]

    id = @read_letter[JSON_PARSE[0].to_s].to_i + 1
    subject = @read_letter[JSON_PARSE[1].to_s][0]
    subject[id] = read_subject.to_s
    from = @read_letter[JSON_PARSE[1].to_s][1]
    from[id] = read_from
    date = @read_letter[JSON_PARSE[1].to_s][2]
    date[id] = read_date
    body = @read_letter[JSON_PARSE[1].to_s][3]
    body[id] = read_body.to_s
    uid = @read_letter[JSON_PARSE[1].to_s][4]
    uid[id] = read_uid

    @read_letter[JSON_PARSE[0].to_s] = @read_letter[JSON_PARSE[0].to_s] + 1
    @read_letter[JSON_PARSE[1].to_s] = [subject, from, date, body, uid]
  end

  def mail_to_json
    letter = {LETTER_STATE[2] => create_letter_information(LETTER_STATE[2]),
              LETTER_STATE[0] => create_letter_information(LETTER_STATE[0]),
              LETTER_STATE[1] => create_letter_information(LETTER_STATE[1])
              }
    write_file(JSON_FILE_NAME, letter)
  end

  def create_letter_information(letter_state)
    @box.letter_information(letter_state)
    {JSON_PARSE[0] => @box.letter_count(letter_state),
     JSON_PARSE[1] => [@box.subject, @box.from, @box.date, @box.body, @box.uid]
    }
  end

  def write_file(file_name, letter)
    File.open(file_name, JSON_FILE_ACCESS) do |line|
      line.write(letter.to_json)
    end
  end

  def read_file(file_name)
    JSON.parse(File.read(file_name))
  end
end
