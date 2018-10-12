require 'rspec'
require_relative '../../WorkWithFiles/features/CucumberProject/code/files'
require '../data'

describe 'Testing WFile class' do

  def output_information
    $stdout.rewind
    $stdout.each_line {|line| @output << line}
    @output.chomp!
  end

  before(:each) do
    $stdout = StringIO.new
    @file = WFile.new
    @output = ''
  end

  after(:each) do
    File.delete(FILE_NAME) if File.exist?(FILE_NAME)
    File.delete(NEW_FILE_NAME) if File.exist?(NEW_FILE_NAME)
    @output = ''
  end

  context 'Create' do
    it 'creates a new file' do
      @file.create(FILE_NAME, W_RIGHT_ACCESS)
      expect(File.exist?(FILE_NAME)).to be
    end

    it 'creates exist file' do
      @file.create(FILE_NAME, W_RIGHT_ACCESS)
      @file.create(FILE_NAME, W_RIGHT_ACCESS)
      expect(output_information).to eq ERROR_FILE_EXIST
    end

    it 'creates a new file with wrong right access' do
      @file.create(FILE_NAME, WRONG_RIGHT_ACCESS)
      expect(output_information).to include(ERROR_CREATE_FILE)
    end

    it "creates a new file with 'r' right access" do
      @file.create(FILE_NAME, R_RIGHT_ACCESS)
      expect(output_information).to include(ERROR_CREATE_FILE)
    end

    it 'creates a new file with default right access' do
      @file.create(FILE_NAME)
      expect(File.writable?(FILE_NAME)).to be
    end
  end

  context 'Rename' do
    it 'rename exist file' do
      @file.create(FILE_NAME, W_RIGHT_ACCESS)
      @file.rename(FILE_NAME, NEW_FILE_NAME)
      expect(File.exist?(FILE_NAME)).not_to be
      expect(File.exist?(NEW_FILE_NAME)).to be
    end

    it 'rename not exist file' do
      @file.rename(FILE_NAME, NEW_FILE_NAME)
      expect(output_information).to eq ERROR_FILE_NOT_EXIST
    end
  end

  context 'Delete' do
    it 'delete exist file' do
      @file.create(FILE_NAME, W_RIGHT_ACCESS)
      @file.delete(FILE_NAME)
      expect(File.exist?(FILE_NAME)).not_to be
    end

    it 'delete not exist file' do
      @file.delete(FILE_NAME)
      expect(output_information).to eq ERROR_FILE_NOT_EXIST
    end
  end

  context 'Manipulation with file' do
    before(:each) do
      @file.create(FILE_NAME, W_RIGHT_ACCESS)
      File.open(FILE_NAME, W_RIGHT_ACCESS) {|line| line.puts DEFAULT_LINE_FILE[0]}
    end

    it "read file with 'r' right access" do
      @file.manipulation_with_file(FILE_NAME, R_RIGHT_ACCESS)
      expect(output_information).to eq DEFAULT_LINE_FILE[0]
    end

    it "write file with 'w' right access and default text" do
      @file.manipulation_with_file(FILE_NAME, W_RIGHT_ACCESS)
      expect(output_information).to eq EMPTY_LINE
    end

    it "write file with 'w+' right access and default text" do
      @file.manipulation_with_file(FILE_NAME, W_UP_RIGHT_ACCESS)
      expect(output_information).to eq EMPTY_LINE
    end

    it "write file with 'a' right access and default text" do
      @file.manipulation_with_file(FILE_NAME, A_RIGHT_ACCESS)
      expect(output_information.strip).to eq DEFAULT_LINE_FILE[0]
    end

    it "write file with 'a+' right access and default text" do
      @file.manipulation_with_file(FILE_NAME, A_UP_RIGHT_ACCESS)
      expect(output_information.strip).to eq DEFAULT_LINE_FILE[0]
    end

    it "write file with 'w' right access and text 'word'" do
      @file.manipulation_with_file(FILE_NAME, W_RIGHT_ACCESS, DEFAULT_LINE_FILE[1])
      expect(output_information).to eq DEFAULT_LINE_FILE[1]
    end

    it "write file with 'w+' right access and text 'word'" do
      @file.manipulation_with_file(FILE_NAME, W_UP_RIGHT_ACCESS, DEFAULT_LINE_FILE[1])
      expect(output_information).to eq DEFAULT_LINE_FILE[1]
    end

    it "write file with 'a' right access and text 'word'" do
      @file.manipulation_with_file(FILE_NAME, A_RIGHT_ACCESS, DEFAULT_LINE_FILE[1])
      expect(output_information).to eq DEFAULT_LINE_FILE[0] << "\n" << DEFAULT_LINE_FILE[1]
    end

    it "write file with 'a+' right access and text 'word'" do
      @file.manipulation_with_file(FILE_NAME, A_UP_RIGHT_ACCESS, DEFAULT_LINE_FILE[1])
      expect(output_information).to eq DEFAULT_LINE_FILE[0] << "\n" << DEFAULT_LINE_FILE[1]
    end

    it "read file with 'r' right access and text 'word'" do
      @file.manipulation_with_file(FILE_NAME, R_RIGHT_ACCESS, DEFAULT_LINE_FILE[1])
      expect(output_information).to eq DEFAULT_LINE_FILE[0]
    end

    it "read file with wrong right access" do
      @file.manipulation_with_file(FILE_NAME, WRONG_RIGHT_ACCESS)
      expect(output_information).to eq ERROR_RIGHT_ACCESS
    end

    it "read not exist file" do
      @file.manipulation_with_file(NEW_FILE_NAME, R_RIGHT_ACCESS)
      expect(output_information).to eq ERROR_FILE_NOT_EXIST
    end

  end

  context 'Output information about created files' do
    it 'output information about files which are not have been created' do
      @file.out_info_about_file
      expect(output_information).to be_nil
    end

    it 'output information about 1 file' do
      @file.create(FILE_NAME, W_RIGHT_ACCESS)
      @file.out_info_about_file
      expect(output_information).to eq "#{FILE_NAME}: w"
    end

    it 'output information about 2 files' do
      @file.create(FILE_NAME, W_RIGHT_ACCESS)
      @file.create(NEW_FILE_NAME, W_RIGHT_ACCESS)
      @file.out_info_about_file
      expect(output_information).to eq output_information_about_file(FILE_NAME) << "\n" << output_information_about_file(NEW_FILE_NAME)
    end

    it "output information about file which was created with default 'w' right access" do
      @file.create(FILE_NAME)
      @file.out_info_about_file
      expect(output_information).to eq output_information_about_file(FILE_NAME)
    end
  end
end
