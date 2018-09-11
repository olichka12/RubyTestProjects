require 'pry'

module WorkFiles

  class Work

    def initialize
      @@files = {}
    end

    def out_info_about_file
      @@files.each {|file, access| puts "#{file}: #{access}"}
    end


    def create (file_name, access_right = 'w') #w, w+, a, a+
      if @@files[file_name.to_sym].nil?
        begin
        File.new(file_name.to_s, access_right.to_s)
        rescue ArgumentError => e
          puts "Filed to create '#{file_name}' file with the following error: '#{e}'"
          return
        end
        @@files[file_name.to_sym] = access_right.to_sym
      else
        puts 'File is exist!'
      end
    end


    def delete(file_name)
      if @@files[file_name.to_sym].nil?
        puts 'File not exist!'
      else
        begin
        File.delete(file_name.to_s)
        rescue StandardError => e
          puts "Filed to delete '#{file_name}' file with the following error: '#{e}'"
          return
        end
        @@files.delete(file_name.to_sym)
      end
    end


    def rename(file_name, new_file_name)
      if @@files[file_name.to_sym].nil?
        puts 'File not exist!'
      else
        begin
        File.rename(file_name.to_s, new_file_name.to_s)
        rescue ArgumentError => e
          puts "Failed to rename '#{file_name}' file with the following error: '#{e}'"
          return
        end
        @@files[new_file_name.to_sym] = @@files.delete(file_name.to_sym)
      end
    end


    def manipulation_with_file(file_name, access_right, write_lines = '') #read, write file
      if @@files[file_name.to_sym].nil?
        puts 'File not exist!'
      else
        begin
          case access_right
          when 'r' # Output all text from file with access right - r
            File.open(file_name.to_s, access_right.to_s).each {|line| puts line}
          when 'w' , 'a' # Write text in to file with access right - w,a
            File.open(file_name.to_s, access_right.to_s) {|line| line.puts write_lines.to_s} unless write_lines.empty?
          when 'r+' , 'w+' , 'a+'  # Write and output text with access right - r+, w+, a+
            File.open(file_name.to_s, access_right.to_s) {|line| line.puts write_lines.to_s} unless write_lines.empty?
            File.open(file_name.to_s, 'r').each {|line| puts line}
          end
        rescue ArgumentError => e
          puts "Filed to open '#{file_name}' file with the following error: '#{e}'"
          return
        rescue IOError => e
          puts "Filed to open '#{file_name}' file with the following error: '#{e}'"
          return
        end
      end
    end

  end

end

class Action
  include WorkFiles

  def initialize
    @file_obj = Work.new
    @choose_continue = 1
    @choose_operation = 0
  end

  def action
    while @choose_continue == 1
      puts 'Choose operation: '
      puts '1 - Output information about all files'
      puts '2 - Create file'
      puts '3 - Rename file'
      puts '4 - Manipulation with file'
      puts '5 - Delete file'
      puts 'Your choose :  '

      begin
        @choose_operation = gets.chomp
        @choose_operation = Integer(@choose_operation)
      rescue ArgumentError => e
        puts "Got the following error: '#{e}'"
        puts 'Please enter integer number: '
        retry
      end

      case @choose_operation
      when 1
        @file_obj.out_info_about_file
      when 2
        puts 'File name: '
        file_name = gets.chomp
        puts 'Access right: '
        access_right = gets.chomp.to_s

        @file_obj.create(file_name) if access_right.empty?
        @file_obj.create(file_name,access_right) unless access_right.empty?

      when 3
        puts 'File name: '
        old_file_name = gets.chomp
        puts 'File name new: '
        new_file_name = gets.chomp
        @file_obj.rename(old_file_name, new_file_name)

      when 4
        puts 'File name: '
        file_name = gets.chomp
        puts 'Access right: '
        access_right = gets.chomp.to_s
        puts 'Write text: '
        text = gets.chomp

        @file_obj.manipulation_with_file(file_name, access_right) if text.empty?
        @file_obj.manipulation_with_file(file_name, access_right, text) unless text.empty?

      when 5
        puts 'File name: '
        file_name = gets.chomp
        @file_obj.delete(file_name)
      end

      puts 'Continue? (1/other key): '
      @choose_continue = 0 unless gets.chomp.to_i == 1
    end
    puts 'The end :)'
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
