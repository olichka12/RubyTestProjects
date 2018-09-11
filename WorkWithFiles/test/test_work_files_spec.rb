require 'rspec'
require '../work_files'

describe 'Testing WorkFiles module' do

  before(:all) do
    @file_name = 'test1.txt'
    @new_file_name = 'test2.txt'
  end

  before(:each) do
    $stdout = StringIO.new
    @obj = WorkFiles::Work.new
  end

  after(:each) do
    File.delete(@file_name) if File.exist?(@file_name)
    File.delete(@new_file_name) if File.exist?(@new_file_name)
  end

  context '#Creation:' do
    it 'new file' do
      @obj.create(@file_name,'w')
      expect(File.exist?(@file_name)).to be true
    end

    it 'existing file' do
      @obj.create(@file_name, 'w')
      @obj.create(@file_name, 'w')
      $stdout.rewind
      expect($stdout.gets.strip).to eq 'File is exist!'
    end

    it 'new file with wrong right access' do
      @obj.create(@file_name,'e')
      $stdout.rewind
      expect($stdout.gets.strip).to include("Filed to create '#{@file_name}' file with the following error: ")
    end

    #output error
    #it "new file with 'r' right access" do
    #  expect(@obj.create(@file_name,'r')).to raise_error ()
    #end
  end

  context '#Renaming:' do
    it 'exist file' do
      @obj.create(@file_name,'w')
      @obj.rename(@file_name, @new_file_name)
      expect(File.exist?(@file_name)).not_to be true
      expect(File.exist?(@new_file_name)).to be true
    end

    it 'not exist file' do
      @obj.rename(@file_name, @new_file_name)
      $stdout.rewind
      expect($stdout.gets.strip).to eq 'File not exist!'
    end
  end

  context '#Deleting:' do
    it 'exist file' do
      @obj.create(@file_name,'w')
      @obj.delete(@file_name)
      expect(File.exist?(@file_name)).not_to be true
    end

    it 'not exist file' do
      @obj.delete(@file_name)
      $stdout.rewind
      expect($stdout.gets.strip).to eq 'File not exist!'
    end
  end

  #do!
  #context 'Manipulation with file:' do
  #
 # end

  context '#Output information about created files if:' do
    it 'files are not have been created' do
      @obj.out_info_about_file
      $stdout.rewind
      expect($stdout.gets).to be_nil
    end

    it 'exist 1 file' do
      @obj.create(@file_name,'w')
      @obj.out_info_about_file
      $stdout.rewind
      expect($stdout.gets.strip).to eq "#{@file_name}: w"
    end
=begin
do!
    it 'exist 2 files' do
      @obj.create(@file_name,'w')
      @obj.create(@new_file_name,'w')
      @obj.out_info_about_file
      $stdout.rewind
      expect($stdout.gets.strip).to eq "#{@file_name}: w#{@new_file_name}: w"
    end
=end
  end

end
