# frozen_string_literal: true

require_relative 'balance_storage'
require_relative 'action_interface'
require_relative 'deposit_interface'
require_relative 'withdraw_interface'

class CashMachine
  def self.init
    CashMachine.new.call
  end

  def initialize
    @balance = BalanceStorage.new('balance.txt').load
    @action_interface = ActionInterface.new
    @deposit_interface = DepositInterface.new
  end

  def call
    loop do
      action = @action_interface.user_action
      break if action == :quit

      send action
    end
  end

  private

  def deposit
    add_to_balance @deposit_interface.input_amount
    balance
  end

  def withdraw
    deduct_from_balance WithdrawInterface.new(@balance).input_amount
    balance
  end

  def balance
    puts "balance: #{@balance}"
  end

  def add_to_balance(amount)
    @balance += amount
  end

  def deduct_from_balance(amount)
    @balance -= amount
  end
end

CashMachine.init
