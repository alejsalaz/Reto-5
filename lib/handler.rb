module Handler
  def file_opener(file_name)
    file = open(file_name)

    yield(file)

  ensure
    file.close if file
  end

  def read_file(file_name)
    file_opener(file_name) do |file|

      while line = file.gets
        puts line
      end
    end
  end

  # TODO: Do this
  def count_lines(file_name)
    file_handler(file_name) do |file|
      count = 0
      while file.gets
        count += 1
      end
      count
    end
  end

end
