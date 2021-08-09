# frozen_string_literal: true

class ActionInterface
  ACTIONS = {
    d: :deposit,
    w: :withdraw,
    b: :balance,
    q: :quit
  }.freeze

  def user_action
    loop do
      print_action
      action = gets.chomp.downcase.to_sym
      return ACTIONS[action] if ACTIONS.keys.include?(action)

      print_suggest_action
    end
  end

  private

  def print_action
    puts 'D (deposit)'
    puts 'W (withdraw)'
    puts 'B (balance)'
    puts 'Q (quit)'
  end

  def print_suggest_action
    puts 'select on of actions: [d, D, w, W, b, B, q, Q]'
  end
end
