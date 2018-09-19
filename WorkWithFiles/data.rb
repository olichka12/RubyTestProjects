FILE_NAME = 'test1.txt'
NEW_FILE_NAME = 'test2.txt'
R_RIGHT_ACCESS = 'r'
W_RIGHT_ACCESS = 'w'
W_UP_RIGHT_ACCESS = 'w+'
A_RIGHT_ACCESS = 'a'
A_UP_RIGHT_ACCESS = 'a+'
DEFAULT_LINE_FILE = %w(Hello word)
EMPTY_LINE = ''

WRONG_RIGHT_ACCESS = 'e'
ERROR_FILE_EXIST = 'File exists!'
ERROR_FILE_NOT_EXIST = 'File does not exist!'
ERROR_RIGHT_ACCESS = 'Wrong right access'
ERROR_CREATE_FILE = "Failed to create '#{FILE_NAME}' file with the following error: "

def output_information_about_file (file_name)
  "#{file_name}: w"
end

def output_error_create_file (file_name, error)
  "Failed to create '#{file_name}' file with the following error: '#{error}'"
end

def output_error_delete_file (file_name, error)
  "Failed to delete '#{file_name}' file with the following error: '#{error}'"
end

def output_error_rename_file (file_name, error)
  "Failed to rename '#{file_name}' file with the following error: '#{error}'"
end

def output_error_open_file (file_name, error)
  "Failed to open '#{file_name}' file with the following error: '#{error}'"
end
