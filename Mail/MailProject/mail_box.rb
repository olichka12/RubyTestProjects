require 'gmail'
require_relative '../../Mail/data'

class MailBox
  attr_accessor :gmail, :information, :body, :date, :subject, :from, :is_login, :uid

  def initialize
    @information = {}
    @body = {}
    @date = {}
    @subject = {}
    @from = {}
    @uid = {}
    @is_login = false
  end

  def login(user_name, user_password)
    @gmail = Gmail.connect(user_name, user_password)
    @is_login = @gmail.logged_in?
  end

  def logout
    @gmail.logout
    @is_login = @gmail.logged_in?
  end

  def letter_information(letter_state)
    if letter_state.to_sym == LETTER_STATE[0]
      letter_subject(LETTER_STATE[0])
      letter_date(LETTER_STATE[0])
      letter_from(LETTER_STATE[0])
      letter_body(LETTER_STATE[0])
      letter_uid(LETTER_STATE[0])
    elsif letter_state.to_sym == LETTER_STATE[1]
      letter_subject(LETTER_STATE[1])
      letter_date(LETTER_STATE[1])
      letter_from(LETTER_STATE[1])
      letter_body(LETTER_STATE[1])
      letter_uid(LETTER_STATE[1])
    else
      letter_subject
      letter_date
      letter_from
      letter_body
      letter_uid
    end
  end

  def letter_count(letter_state = nil)
    if(letter_state == LETTER_STATE[0])
      @gmail.inbox.count(LETTER_STATE[0])
    elsif (letter_state == LETTER_STATE[1])
      @gmail.inbox.count(LETTER_STATE[1])
    else
      @gmail.inbox.count
    end
  end

  private
  def letter_uid(letter_state = nil)
    letter_state.nil? ? letter_uid_find_all : letter_uid_find(letter_state)
    @uid = @information
  end

  def letter_uid_find(letter_state)
    key = KEY_START
    @gmail.inbox.find(letter_state).each do |letter|
      @information[key += 1] = letter.uid
    end
  end

  def letter_uid_find_all
    key = KEY_START
    @gmail.inbox.find.each do |letter|
      @information[key += 1] = letter.uid
    end
  end

  def letter_body(letter_state = nil)
    @body = {}
    letter_find(letter_state, LETTER_BODY)
  end

  def letter_subject(letter_state = nil)
    letter_find(letter_state, LETTER_SUBJECT)
    @subject = @information
  end

  def letter_date(letter_state = nil)
    letter_find(letter_state, LETTER_DATE)
    @date = @information
  end

  def letter_from(letter_state = nil)
    letter_find(letter_state, LETTER_FROM)
    @from = @information
  end

  def letter_find(letter_state = nil, categorize)
    @information = {}
    letter_state.nil? ? letter_without_state_find(categorize) : letter_state_find(letter_state, categorize)
  end

  def letter_without_state_find(categorize)
    categorize == LETTER_BODY ? letter_body_find : letter_other_find(categorize)
  end

  def letter_other_find(categorize)
    key = KEY_START
    @gmail.inbox.find.each do |letter|
      letter.header[categorize] ? @information[key += 1] = letter.header[categorize] : nil
    end
  end

  def letter_body_find
    key = KEY_START
    @gmail.inbox.find.each do |letter|
      letter.text_part ? (@body[key += 1] = letter.text_part.body.decoded.to_s.force_encoding('utf-8')) : nil
    end
  end

  def letter_state_find(letter_state, categorize)
    categorize == LETTER_BODY ? letter_state_body_find(letter_state) : letter_state_other_find(letter_state, categorize)
  end

  def letter_state_other_find(letter_state, categorize)
    key = KEY_START
    @gmail.inbox.find(letter_state).each do |letter|
      letter.header[categorize] ? @information[key += 1] = letter.header[categorize] : nil
    end
  end

  def letter_state_body_find(letter_state)
    key = KEY_START
    @gmail.inbox.find(letter_state).each do |letter|
      letter.text_part ? (@body[key += 1] = letter.text_part.body.decoded.to_s.force_encoding('utf-8')) : nil
    end
  end
end
