load 'files.rb'

class Action

  def initialize
    @file_obj = WFile.new
    @choose_continue = 1
    @choose_operation = ''
  end

  def action
    while @choose_continue == 1
      puts 'Choose operation: '
      puts 'output - Output information about all files'
      puts 'create - Create file'
      puts 'rename - Rename file'
      puts 'manipulation - Manipulation with file'
      puts 'delete - Delete file'
      puts 'exit - Exit'
      puts 'Your choose :  '

      @choose_operation = gets.strip

      case @choose_operation
      when 'output' then @file_obj.out_info_about_file
      when 'create' then create
      when 'rename' then rename
      when 'manipulation' then manipulation
      when 'delete' then delete
      when 'exit' then return
      else
        puts 'Not exist this operation. Try again? (1/other key)'
        return unless gets.chomp.to_i == 1
      end

    end

  end

  def create
    puts 'File name: '
    file_name = gets.chomp
    puts 'Access right: '
    access_right = gets.chomp.to_s

    @file_obj.create(file_name) if access_right.empty?
    @file_obj.create(file_name,access_right) unless access_right.empty?
  end

  def rename
    puts 'File name: '
    old_file_name = gets.chomp
    puts 'File name new: '
    new_file_name = gets.chomp
    @file_obj.rename(old_file_name, new_file_name)
  end

  def delete
    puts 'File name: '
    file_name = gets.chomp
    @file_obj.delete(file_name)
  end

  def manipulation
    puts 'File name: '
    file_name = gets.chomp
    puts 'Access right: '
    access_right = gets.chomp.to_s
    puts 'Write text: '
    text = gets.chomp

    @file_obj.manipulation_with_file(file_name, access_right) if text.empty?
    @file_obj.manipulation_with_file(file_name, access_right, text) unless text.empty?
  end

end


#act = Action.new
#act.action



=begin
Access to file
  r  - read only; start
  r+ - read and write; start
  w  - write only; start;       recreate
  w+ - read and write; start    recreate
  a  - write only; end          add
  a+ - read, write; end         add
  b  - binary (windows, dos)

=end