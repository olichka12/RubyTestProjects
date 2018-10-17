require 'sinatra'
require_relative 'mail_box'
require_relative '../../Mail/data'
require 'pry'

before do
  @box = MailBox.new
end

after do
  @box.logout
end

get '/' do
  erb :start_page, :locals => {'user_name' => USER_NAME,
                               'all_count' => @box.letter_count,
                               'unread_count' => @box.letter_count(LETTER_STATE[0]),
                               'read_count' => @box.letter_count(LETTER_STATE[1])
                              }
end

get '/letter/:letter_state' do
  @box.letter_information(params[:letter_state], params[:letter_number])
  erb :letter_page, :locals => {'user_name' => USER_NAME,
                                'letter_state' => "#{params[:letter_state]}",
                                'no_subject' => LETTER_NO_SUBJECT,
                                'letters_subject' => @box.subject
                                }
end

get '/letter_same/:letter_state/:letter_number' do
  @box.letter_information(params[:letter_state].split(WHITESPACE)[0], params[:letter_number], true)
  erb :letter_same_page, :locals => { 'lsubject' => @box.subject[params[:letter_number].to_i],
                                      'lfrom' => @box.from[params[:letter_number].to_i],
                                      'ldate' => @box.date[params[:letter_number].to_i],
                                      'lbody' => @box.body[params[:letter_number].to_i]
                                    }
end
