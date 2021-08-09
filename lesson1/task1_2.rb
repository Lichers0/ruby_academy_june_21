# frozen_string_literal: true

class Pokemons
  def initialize
    puts 'How many pokemons?'
    @pokemons_count = gets.chomp.to_i
  end

  def input_data_pokemons
    (1..@pokemons_count).inject([]) do |result, _|
      puts 'name:'
      name = gets.chomp
      puts 'color:'
      color = gets.chomp

      result << { name: name, color: color }
    end
  end
end

data = Pokemons.new.input_data_pokemons
p data
