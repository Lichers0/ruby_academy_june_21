# frozen_string_literal: true

require_relative 'balance_storage'

class CashMachine
  METHODS = %w[deposit withfraw balance].freeze

  def initialize
    @balance_storage = BalanceStorage.new('balance.txt')
    @balance = balance_storage.load

    @response = Rack::Response.new
  end

  def call(env)
    @request = Rack::Request.new(env)
    create_answer
    @response.finish
  end

  private

  attr_reader :balance_storage

  def create_answer
    if @request.get?
      send request_action
    else
      error 'Method must be GET'
    end
  end

  def request_action
    @request.path[1..-1]
  end

  def value
    @request.params['value'].to_f
  end

  def deposit
    if value.positive?
      add_to_balance value
      balance
    else
      error 'Value mush be positive'
    end
  end

  def withdraw
    if value.positive? && value <= @balance
      deduct_from_balance value
      balance
    else
      error "Value must be between 0 and #{@balance}"
    end
  end

  def balance
    @response.body = ["balance: #{@balance}"]
  end

  def error(text)
    @response.set_header('Content-Type', 'text/plain')
    @response.status = 400
    @response.body = ["Error: #{text}"]
  end

  def add_to_balance(amount)
    @balance += amount
    save
  end

  def deduct_from_balance(amount)
    @balance -= amount
    save
  end

  def save
    balance_storage.save(@balance)
  end
end
