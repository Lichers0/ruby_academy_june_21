# frozen_string_literal: true

class BalanceStorage
  DEFAULT_BALANCE = 100.0

  def initialize(filename)
    @filename = filename
  end

  def load
    return DEFAULT_BALANCE unless File.exist?(@filename)

    File.read(@filename).chomp.to_f
  end

  def save(new_balance)
    File.write(@filename, new_balance)
  end
end
