require 'rspec'
require '../files'

describe 'Testing WFile class' do

  FILE_NAME = 'test1.txt'
  NEW_FILE_NAME = 'test2.txt'

  before(:each) do
    $stdout = StringIO.new
    @obj = WFile.new
    @output = ''
  end

  after(:each) do
    File.delete(FILE_NAME) if File.exist?(FILE_NAME)
    File.delete(NEW_FILE_NAME) if File.exist?(NEW_FILE_NAME)
    @output = ''
  end

  context '#Creation:' do
    it 'new file' do
      @obj.create(FILE_NAME,'w')
      expect(File.exist?(FILE_NAME)).to be true
    end

    it 'existing file' do
      @obj.create(FILE_NAME, 'w')
      @obj.create(FILE_NAME, 'w')
      $stdout.rewind
      expect($stdout.gets.strip).to eq 'File is exist!'
    end

    it 'new file with wrong right access' do
      @obj.create(FILE_NAME,'e')
      $stdout.rewind
      expect($stdout.gets.strip).to include("Filed to create '#{FILE_NAME}' file with the following error: ")
    end

    it "new file with 'r' right access" do
      @obj.create(FILE_NAME,'r')
      $stdout.rewind
      expect($stdout.gets.strip).to include ("Filed to create '#{FILE_NAME}' file with the following error:")
    end

    it 'new file without right access' do
      @obj.create(FILE_NAME)
      expect(File.writable?(FILE_NAME)).to be true
    end
  end

  context '#Renaming:' do
    it 'exist file' do
      @obj.create(FILE_NAME,'w')
      @obj.rename(FILE_NAME, NEW_FILE_NAME)
      expect(File.exist?(FILE_NAME)).not_to be true
      expect(File.exist?(NEW_FILE_NAME)).to be true
    end

    it 'not exist file' do
      @obj.rename(FILE_NAME, NEW_FILE_NAME)
      $stdout.rewind
      expect($stdout.gets.strip).to eq 'File not exist!'
    end
  end

  context '#Deleting:' do
    it 'exist file' do
      @obj.create(FILE_NAME,'w')
      @obj.delete(FILE_NAME)
      expect(File.exist?(FILE_NAME)).not_to be true
    end

    it 'not exist file' do
      @obj.delete(FILE_NAME)
      $stdout.rewind
      expect($stdout.gets.strip).to eq 'File not exist!'
    end
  end

  context 'Manipulation with file:' do
    before(:each) do
      @obj.create(FILE_NAME,'w')
      File.open(FILE_NAME,'w') {|line| line.puts 'Hello'}
    end

    it "read file with 'r' right access" do
      @obj.manipulation_with_file(FILE_NAME, 'r')
      $stdout.rewind
      expect($stdout.gets.strip).to eq 'Hello'
    end

    it "write file with 'w' right access and default text" do
      @obj.manipulation_with_file(FILE_NAME,'w')
      $stdout.rewind
      expect($stdout.gets.strip).to eq ''
    end

    it "write file with 'w+' right access and default text" do
      @obj.manipulation_with_file(FILE_NAME,'w+')
      $stdout.rewind
      expect($stdout.gets.strip).to eq ''
    end

    it "write file with 'a' right access and default text" do
      @obj.manipulation_with_file(FILE_NAME,'a')
      $stdout.rewind
      expect($stdout.gets).to eq "Hello\n"
    end

    it "write file with 'a+' right access and default text" do
      @obj.manipulation_with_file(FILE_NAME,'a+')
      $stdout.rewind
      expect($stdout.gets).to eq "Hello\n"
    end

    it "write file with 'w' right access and text ' word'" do
      @obj.manipulation_with_file(FILE_NAME,'w', ' word')
      $stdout.rewind
      expect($stdout.gets.chomp).to eq ' word'
    end

    it "write file with 'w+' right access and text ' word'" do
      @obj.manipulation_with_file(FILE_NAME,'w+', ' word')
      $stdout.rewind
      expect($stdout.gets.chomp).to eq ' word'
    end

    it "write file with 'a' right access and text ' word'" do
      @obj.manipulation_with_file(FILE_NAME,'a', ' word')
      $stdout.rewind
      $stdout.each_line {|l| @output << l}
      expect(@output.strip).to eq "Hello\n word"
    end

    it "write file with 'a+' right access and text ' word'" do
      @obj.manipulation_with_file(FILE_NAME,'a+', ' word')
      $stdout.rewind
      $stdout.each_line {|l| @output << l}
      expect(@output.strip).to eq "Hello\n word"
    end

    it "read file with 'r' right access and text ' word'" do
      @obj.manipulation_with_file(FILE_NAME, 'r', ' word')
      $stdout.rewind
      expect($stdout.gets.strip).to eq 'Hello'
    end

    it "read file with wrong right access" do
      @obj.manipulation_with_file(FILE_NAME, 'e')
      $stdout.rewind
      expect($stdout.gets.strip).to eq 'Wrong right access'
    end

    it "read not exist file" do
      @obj.manipulation_with_file(NEW_FILE_NAME, 'r')
      $stdout.rewind
      expect($stdout.gets.strip).to eq 'File not exist!'
    end

  end

  context '#Output information about created files if:' do
    it 'files are not have been created' do
      @obj.out_info_about_file
      $stdout.rewind
      expect($stdout.gets).to be_nil
    end

    it 'exist 1 file' do
      @obj.create(FILE_NAME,'w')
      @obj.out_info_about_file
      $stdout.rewind
      expect($stdout.gets.strip).to eq "#{FILE_NAME}: w"
    end

    it 'exist 2 files' do
      @obj.create(FILE_NAME,'w')
      @obj.create(NEW_FILE_NAME,'w')
      @obj.out_info_about_file
      $stdout.rewind
      $stdout.each_line {|l| @output << l}
      expect(@output.strip).to eq "#{FILE_NAME}: w\n#{NEW_FILE_NAME}: w"
    end

  end

end