# frozen_string_literal: true

class DepositInterface
  def input_amount
    loop do
      notification
      amount = gets.chomp.to_f
      return amount if amount.positive?
    end
  end

  private

  def notification
    puts 'Deposit. Input positive amount:'
  end
end
