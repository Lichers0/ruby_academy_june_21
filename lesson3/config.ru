# frozen_string_literal: true

require_relative 'cash_machine'

use Rack::Reloader
# use Rack::ContentType, 'text/plain'
run Rack::URLMap.new(
  {
    '/withdraw' => CashMachine.new,
    '/deposit' => CashMachine.new,
    '/balance' => CashMachine.new
  }
)
