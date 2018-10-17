require 'gmail'
require_relative '../../Mail/data'
require 'pry'

class MailBox
  attr_accessor :gmail, :information, :body, :date, :subject, :from

  def initialize
    @gmail = Gmail.connect(USER_NAME, USER_PASSWORD)
    @information = {}
    @body = {}
    @date = {}
    @subject = {}
    @from = {}
  end

  def logout
    @gmail.logout
  end

  def letter_information(letter_state, number, read = false)
    if letter_state.to_sym == LETTER_STATE[0]
      letter_subject(LETTER_STATE[0])
      letter_date(LETTER_STATE[0])
      letter_from(LETTER_STATE[0])
      letter_body(LETTER_STATE[0])
      letter_read(number) if read
    elsif letter_state.to_sym == LETTER_STATE[1]
      letter_subject(LETTER_STATE[1])
      letter_date(LETTER_STATE[1])
      letter_from(LETTER_STATE[1])
      letter_body(LETTER_STATE[1])
    else
      letter_subject
      letter_date
      letter_from
      letter_body
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
  def letter_read(number)
    key = KEY_START
    @letters = {}
    @gmail.inbox.find(LETTER_STATE[0],:date => @date[number.to_i]) do |letter|
      @letters[key += 1] = letter
    end
    @letters.invert
    @gmail.inbox.find(:uid => @letters[number.to_i].uid) do |letter|
      letter.read!
    end
  end

  def letter_body(letter_state = nil)
    letter_find(letter_state, LETTER_BODY)
    @body = @information
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
      letter.header[categorize] ? @information[key += 1] = letter.header[categorize].decoded : nil
    end
  end

  def letter_body_find
    key = KEY_START
    @gmail.inbox.find.each do |letter|
      letter.text_part ? (@information[key += 1] = letter.text_part.body.decoded) : nil
    end
  end

  def letter_state_find(letter_state, categorize)
    categorize == LETTER_BODY ? letter_state_body_find(letter_state) : letter_state_other_find(letter_state, categorize)
  end

  def letter_state_other_find(letter_state, categorize)
    key = KEY_START
    @gmail.inbox.find(letter_state).each do |letter|
      letter.header[categorize] ? @information[key += 1] = letter.header[categorize].decoded : nil
    end
  end

  def letter_state_body_find(letter_state)
    key = KEY_START
    @gmail.inbox.find(letter_state).each do |letter|
      letter.text_part ? (@information[key += 1] = letter.text_part.body.decoded) : nil
    end
  end
end

#  box = MailBox.new
#  box.letter_information(LETTER_STATE[0])
# puts box.body[2]
