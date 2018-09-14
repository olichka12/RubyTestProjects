class WFile

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
      rescue StandardError => e
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
          File.open(file_name.to_s, access_right.to_s) {|line| line.puts write_lines.to_s} #unless write_lines.empty?
          File.open(file_name.to_s, 'r').each {|line| puts line}
        when 'r+' , 'w+' , 'a+'  # Write and output text with access right - r+, w+, a+
          File.open(file_name.to_s, access_right.to_s) {|line| line.puts write_lines.to_s} #unless write_lines.empty?
          File.open(file_name.to_s, 'r').each {|line| puts line}
        else puts 'Wrong right access'
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