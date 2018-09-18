FILE_NAME = 'test1.txt'
NEW_FILE_NAME = 'test2.txt'
W_RIGHT_ACCESS = 'w'
ERROR_FILE_EXIST = 'File exists!'
ERROR_FILE_NOT_EXIST = 'File not exists!'
ERROR_CREATE_FILE = "Failed to create '#{FILE_NAME}' file with the following error: "

Before do
  @file = WFile.new
  $stdout = StringIO.new
  @output = ''
end

After do
  File.delete(FILE_NAME) if File.exist?(FILE_NAME)
  File.delete(NEW_FILE_NAME) if File.exist?(NEW_FILE_NAME)
  @output = ''
end

Given /^I have (.*$)/ do |file|
  @file.create(FILE_NAME, W_RIGHT_ACCESS) if file['a file']
  puts 'I have ' << file
end

When /^I  (.*) a file$/ do |action|
  case action
  when 'renaming'
    @file.rename(FILE_NAME, NEW_FILE_NAME)
  when 'deleting'
    @file.delete(FILE_NAME)
  end
end

When /^I creates file with (.*) right access$/ do |access|
  if access == 'default'
    @file.create(FILE_NAME, W_RIGHT_ACCESS)
  else
    @file.create(FILE_NAME, access)
  end
  puts "I creates file with #{access} right access"
end

Then /^I display the result of (.*$)/ do |action|
  case action
  when 'renaming'
    output_renaming
  when 'deleting'
    output_deleting
  when 'creating'
    output_creating
  end
end



def output_information
  $stdout.rewind
  $stdout.each_line {|line| @output << line}
  @output.chomp!
end

def output_renaming
  puts '  Successful renaming a file!' if File.exist?(NEW_FILE_NAME)
  puts '  Failed renaming a file!' unless File.exist?(NEW_FILE_NAME)
  puts '  File not exists!' if output_information == ERROR_FILE_NOT_EXIST
end

def output_deleting
  puts '  Failed deleting a file!' if File.exist?(NEW_FILE_NAME)
  puts '  Failed deleting! File not exists!' if output_information == ERROR_FILE_NOT_EXIST
  puts '  Successful deleting a file!' if (File.exist?(NEW_FILE_NAME) == false && output_information.nil?)
end

def output_creating
  if File.exist?(FILE_NAME) && output_information.nil?
    puts '  Successful creating a file'
  elsif !File.exist?(FILE_NAME)
    puts '  Failed creating a file' if output_information[ERROR_CREATE_FILE]
  else
    puts '  Failed creating a file! File is already existing!' if output_information[ERROR_FILE_EXIST]
  end
end
