require 'rspec'
require_relative '../../Mail/TestProject/spec_helper'

describe 'Mail tests' do
  context 'Mailbox' do
    before(:each) do
      @mail_box = MailBox.new
      @mail_box.login(USER_NAME ,USER_PASSWORD)
    end

    it 'verifies that user can login with correct mailbox and password' do
      @mail_box.login(USER_NAME, USER_PASSWORD)
      expect(@mail_box.is_login).to be
    end

    it 'verifies that user can not login with correct mailbox and password' do
      @mail_box.login(USER_NAME, USER_PASSWORD_WRONG)
      expect(@mail_box.is_login).not_to be
    end

    it 'verifies that user can logout' do
      @mail_box.logout
      expect(@mail_box.is_login).not_to be
    end

    it 'verifies that count all letters in mailbox equals sum read and unread letters' do
      expect(@mail_box.letter_count(LETTER_STATE[0]) + @mail_box.letter_count(LETTER_STATE[1])).to eq @mail_box.letter_count(LETTER_STATE[2])
    end
  end

  context 'Reading and parsing json file' do
    before(:all) do
      @json_parser = MailJSON.new
      @json_parser.write_mail_json(USER_NAME, USER_PASSWORD)
    end

    it 'verifies that count all letters in the json file equals sum read and unread letters' do
      @json_parser.count_mail_json
      expect(@json_parser.unread_count + @json_parser.read_count).to eq @json_parser.all_count
    end

    it 'verifies that subjects of all letters in the json file is not empty' do
      @json_parser.subject_mail_json(LETTER_STATE[2])
      expect(@json_parser.subject).not_to eq nil
    end

    it 'verifies that subject of second letters in the json file is rightly' do
      @json_parser.letter_json(LETTER_STATE[2], LETTER_NUMBER)
      expect(@json_parser.subject[LETTER_NUMBER.to_s]).to eq LETTER_TEST[0]
    end

    it 'verifies that sender of second letters in the json file is rightly' do
      @json_parser.letter_json(LETTER_STATE[2], LETTER_NUMBER)
      expect(@json_parser.from[LETTER_NUMBER.to_s]).to eq LETTER_TEST[1]
    end

    it 'verifies that date of second letters in the json file is rightly' do
      @json_parser.letter_json(LETTER_STATE[2], LETTER_NUMBER)
      expect(@json_parser.date[LETTER_NUMBER.to_s]).to eq LETTER_TEST[2]
    end

    it 'verifies that body of second letters in the json file is rightly' do
      @json_parser.letter_json(LETTER_STATE[2], LETTER_NUMBER)
      expect(@json_parser.body[LETTER_NUMBER.to_s]).to eq LETTER_TEST[3]
    end
  end
end
