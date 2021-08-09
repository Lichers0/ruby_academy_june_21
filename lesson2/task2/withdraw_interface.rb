# frozen_string_literal: true

class WithdrawInterface
  def initialize(balance)
    @balance = balance
  end

  def input_amount
    loop do
      notification
      amount = gets.chomp.to_f
      return amount if correct? amount

      print_suggestion
    end
  end

  private

  def correct?(amount)
    amount.between?(0, @balance)
  end

  def notification
    puts 'Withdraw. Input amount:'
  end

  def print_suggestion
    puts "The amount should be between 0 and #{@balance}"
  end
end
