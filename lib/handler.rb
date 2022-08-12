# Handler contiene los métodos encargados de manipular los archivos de texto.
module Handler
  def file_opener(file_name)
    file = File.open(file_name)

    yield(file)
  ensure
    file.close & file
  end

  def read_file(file_name)
    file_opener(file_name) do |file|
      while (line = file.gets)
        puts line
      end
    end
  end

  # TODO: Do this
  def count_lines(file_name)
    file_handler(file_name) do |file|
      count = 0
      count += 1 while file.gets
      count
    end
  end
end
