# frozen_string_literal: true

class Task
  def initialize(data)
    @data = data
  end

  def result
    return two_to_the_string_length_power if last_symbols_cs?

    reverse_data
  end

  private

  def last_symbols_cs?
    return true if @data[-2..-1] == 'cs'

    false
  end

  def reverse_data
    @data.reverse
  end

  def two_to_the_string_length_power
    2**@data.length
  end
end

puts 'Input string'
input_string = gets.chomp

puts Task.new(input_string).result
