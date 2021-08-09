# frozen_string_literal: true

require 'rack'

class App
  def call(env)
    req = Rack::Request.new(env)

    case req.path
    when '/hi'
      [200, { 'Content-Type' => 'text/html' }, ['Hi']]
    when '/bye'
      [200, { 'Content-Type' => 'text/html' }, ['Bye']]
    else
      [404, { 'Content-Type' => 'text/html' }, ['Not found']]
    end
  end
end
