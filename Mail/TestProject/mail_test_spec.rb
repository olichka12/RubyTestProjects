require 'rspec'
require_relative '../../Mail/TestProject/spec_helper'

describe 'Mail tests' do

  context 'User loginned' do
    before(:each) do
      @mail_box = MailBox.new
    end

    it 'verifies that user is loginned' do
      @mail_box.login(USER_NAME, USER_PASSWORD)
      expect(@mail_box.is_login).to be
    end
  end

  context 'Letters counts' do
    before(:each) do
      @mail_box = MailBox.new
      @mail_box.login(USER_NAME ,USER_PASSWORD)
    end

    it 'verifies that count all letters in mail box equals sum read and unread letters' do
      expect(@mail_box.letter_count(LETTER_STATE[0]) + @mail_box.letter_count(LETTER_STATE[1])).to eq @mail_box.letter_count(LETTER_STATE[2])
    end
  end

end
