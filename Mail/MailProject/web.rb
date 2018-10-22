require 'sinatra'
require_relative '../MailProject/mail_json_parse'
require_relative '../../Mail/data'

get '/' do
  redirect to('/start_page')
end

get '/start_page' do
    erb :start_page
end

post '/start_page' do
  mail = MailJSON.new
  mail.write_mail_json(params[:user_mail], params[:user_password])
  mail.login ? (redirect to("/user_page/#{params[:user_mail]}")) : (redirect to('/start_page'))
end

get '/user_page/:user_name' do
  mail = MailJSON.new
  mail.count_mail_json
  erb :user_page, :locals => {'user_name' => params[:user_name],
                              'all_count' => mail.all_count,
                              'unread_count' => mail.unread_count,
                              'read_count' => mail.read_count
                              }
end

get '/:user_name/letter/:letter_state' do
  mail = MailJSON.new
  mail.subject_mail_json(params[:letter_state])
  erb :letter_page, :locals => {'user_name' => params[:user_name],
                                'letter_state' => params[:letter_state],
                                'no_subject' => LETTER_NO_SUBJECT,
                                'letters_subject' => mail.subject
                                }
end

get '/:user_name/letter_same/:letter_state/:letter_number' do
  mail = MailJSON.new
  mail.letter_json(params[:letter_state], params[:letter_number])
  erb :letter_same_page, :locals => { 'lsubject' => mail.subject[params[:letter_number]],
                                      'lfrom' => mail.from[params[:letter_number]],
                                      'ldate' => mail.date[params[:letter_number]],
                                      'lbody' => mail.body[params[:letter_number]],
                                      'user_name' => params[:user_name]
                                    }
end
