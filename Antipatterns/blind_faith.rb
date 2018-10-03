class WFile
  def initialize
    @@files = {}
  end

  def out_info_about_file
    @@files.each {|file, access| puts "#{file}: #{access}"}
  end

  def create (file_name, access_right = 'w')
    if @@files[file_name.to_sym].nil?
      File.new(file_name.to_s, access_right.to_s)
      @@files[file_name.to_sym] = access_right.to_sym
    end
  end
end
