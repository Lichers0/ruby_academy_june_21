# frozen_string_literal: true

# Object for work with output file
class OutputFile
  def initialize(filename)
    @filename = filename
  end

  def save(lines)
    File.write(@filename, lines.join("\n"), mode: 'a') if lines.any?
  end

  def print_result
    File.foreach(@filename) { |line| puts line }
  end
end

# Object for work with input file
class InputFile
  def initialize(filename)
    @filename = filename
    @temp_filename = 'temp.tmp'
  end

  def empty?
    @count_line.zero?
  end

  def select(_age)
    @count_line = 0
    result = []
    File.open(@temp_filename, 'w') do |temp_file|
      sort_by_filter(temp_file, age1)
    end
    update_input_file

    result
  end

  private

  def sort_by_filter(temp_file, age)
    File.foreach(@filename) do |line|
      if age(line) == age
        result << line
      else
        temp_file.write line
        @count_line += 1
      end
    end
  end

  def update_input_file
    File.delete(@filename)
    File.rename(@temp_filename, @filename)
  end

  def age(line)
    line.split(' ')[-1]
  end
end

# Main class for selectet students
class StudentSelector
  def initialize(input_file:, output_file:)
    @input_file = input_file
    @output_file = output_file
  end

  def call
    loop do
      age = user_input
      @output_file.save(@input_file.select(age))
      break if @input_file.empty? || age == '-1'
    end

    @output_file.print_result
  end

  private

  def user_input
    puts 'Age'
    gets.chomp
  end
end

StudentSelector.new(
  input_file: InputFile.new('input_data.txt'),
  output_file: OutputFile.new('result.txt')
).call
