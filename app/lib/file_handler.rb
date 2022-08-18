# frozen_string_literal: true

# Handler contiene los métodos encargados de manipular los archivos de texto.
module FileHandler
  def file_opener(file_name)
    file = File.file?(file_name) ? File.open(file_name) : File.open('app/assets/error.txt')

    yield(file)
  ensure
    file.close&.file
  end

  def print_file(file_name)
    file_opener(file_name) do |file|
      while (line = file.gets)
        puts line
      end
    end
  end

  def read_file(file_name)
    content = []

    file_opener(file_name) do |file|
      while (line = file.gets)
        content << line
      end
    end

    content
  end

  def write_file(file_name, content)
    file_opener(file_name) do |file|
      File.write(file, content.join, mode: 'w')
    end
  end

  def read_line(file_name, line)
    line > count_lines(file_name) ? 'Error' : IO.readlines(file_name, chomp: true)[line]
  end

  def write_lines(file_name, lines)
    file_opener(file_name) do |file|
      lines.each { |line| File.write(file, "#{line}\n", mode: 'a') }
    end
  end

  def overwrite_lines(file_name, line_number, new_lines)
    file_content = read_file(file_name)
    file_content[line_number] = "#{new_lines[0]}\n"
    file_content[line_number + 1] = "#{new_lines[1]}\n"
    write_file(file_name, file_content)
  end

  def delete_lines(file_name, line_number)
    file_content = read_file(file_name)
    2.times { file_content.delete_at(line_number + 1) }
    write_file(file_name, file_content)
  end

  def count_lines(file_name)
    file_opener(file_name) do |file|
      count = 0
      count += 1 while file.gets
      count
    end
  end
end
