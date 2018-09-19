require_relative '../../../data'

def output_information
  $stdout.rewind
  $stdout.each_line {|line| @output << line}
  @output.chomp!
end

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
  if file == 'a file'
    @file.create(FILE_NAME, W_RIGHT_ACCESS)
  elsif file == '2 files'
    @file.create(FILE_NAME, W_RIGHT_ACCESS)
    @file.create(NEW_FILE_NAME, W_RIGHT_ACCESS)
  end
end

And /^with default text$/ do
  File.open(FILE_NAME, W_RIGHT_ACCESS) {|line| line.puts DEFAULT_LINE_FILE[0]}
end

When /^I rename a file$/ do
  @file.rename(FILE_NAME, NEW_FILE_NAME)
end

When /^I delete a file$/ do
  @file.delete(FILE_NAME)
end

When /^I create file with (.*) right access$/ do |access|
  if access == 'default'
    @file.create(FILE_NAME, W_RIGHT_ACCESS)
  else
    @file.create(FILE_NAME, access)
  end
end

When /^I read file$/ do
  @file.manipulation_with_file(FILE_NAME,R_RIGHT_ACCESS)
end

When /^I write text in to file with (.*) right access$/ do |access|
  @file.manipulation_with_file(FILE_NAME, access, DEFAULT_LINE_FILE[1])
end

When /^I write default text in to file with (.*) right access$/ do |access|
  @file.manipulation_with_file(FILE_NAME, access)
end

When /^I read a file$/ do
  @file.manipulation_with_file(FILE_NAME, R_RIGHT_ACCESS)
end

When /^output information about created files$/ do
  @file.out_info_about_file
end

Then /^file was renamed$/ do
  expect(File.exist?(NEW_FILE_NAME)).to be
end

Then /^file was not renamed$/ do
  expect(output_information).to eq ERROR_FILE_NOT_EXIST
end

Then /^file was deleted$/ do
  expect(File.exist?(FILE_NAME)).not_to be
end

Then /^file was not deleted$/ do
  expect(output_information).to eq ERROR_FILE_NOT_EXIST
end

Then /^file with (.*) right access was created$/ do |access|
  expect(File.exist?(FILE_NAME)).to be
end

Then /^file with (.*) right access was not created$/ do |access|
  expect(output_information).to include(ERROR_CREATE_FILE)
end

Then /^existing file with (.*) right access was not created$/ do |access|
  expect(output_information).to include(ERROR_FILE_EXIST)
end

Then /^I see the default text with (.*) right access$/ do |access|
  case access
  when 'w' || 'w+' || 'default'
    expect(output_information).to eq EMPTY_LINE
  when 'a' || 'a+'
    expect(output_information.chomp).to eq DEFAULT_LINE_FILE[0]
  when 'e'
    expect(output_information).to eq ERROR_RIGHT_ACCESS
  end
end

Then /^I see the text with (.*) right access$/ do |access|
  case access
  when 'w' || 'w+' || 'default'
    expect(output_information).to eq DEFAULT_LINE_FILE[1]
  when 'a' || 'a+'
    expect(output_information).to eq DEFAULT_LINE_FILE[0] << "\n" << DEFAULT_LINE_FILE[1]
  when 'e'
    expect(output_information).to eq ERROR_RIGHT_ACCESS
  end
end

Then /^I see the text from file$/ do
  expect(output_information).to eq DEFAULT_LINE_FILE[0]
end

Then /^I see error message$/ do
  expect(output_information).to eq ERROR_FILE_NOT_EXIST
end

Then /^I do not see information about files$/ do
  expect(output_information).to be nil
end

Then /^I see information about file$/ do
  expect(output_information).to eq output_information_about_file(FILE_NAME)
end

Then /^I see information about files$/ do
  expect(output_information).to eq output_information_about_file(FILE_NAME) << "\n" << output_information_about_file(NEW_FILE_NAME)
end
