module Resource
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      verb = user_resource
      return if verb == 'q'

      method = routes[verb]

      unless method
        puts 'Incorrect resources'
        next
      end

      if verb == 'GET'
        loop do
          action = user_get_action
          return if action == 'q'

          if method[action]
            method = method[action]
            break
          end

          puts 'Incorrect action'
        end
      end

      method.call
    end
  end

  private

  def user_resource
    print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
    gets.chomp
  end

  def user_get_action
    print 'Choose action (index/show) / q to exit: '
    gets.chomp
  end
end

class BaseController
  extend Resource

  def initialize
    @resource = []
  end

  def index
    puts @resource.map.with_index { |value, index| "#{index}. #{value}" }.join('\n')
  end

  def show
    puts @resource[user_index]
  end

  def create
    @resource << user_post_text
    puts 'created'
  end

  def update
    @resource[user_index] = user_post_text
    puts 'updated'
  end

  def destroy
    @resource.delete_at user_index
    puts 'destroyed'
  end

  private

  def user_index
    puts 'Input index'
    gets.chomp.to_i
  end

  def user_post_text
    puts 'Input test of post'
    gets.chomp
  end
end

class PostsController < BaseController
end

class CommentsController < BaseController
end

class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')
    resources(CommentsController, 'comments')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choise = gets.chomp

      PostsController.connection(@routes['posts']) if choise == '1'
      CommentsController.connection(@routes['posts']) if choise == '2'
      break if choise == 'q'
    end

    puts 'Good bye!'
  end

  def resources(klass, keyword)
    controller = klass.new
    @routes[keyword] = {
      'GET' => {
        'index' => controller.method(:index),
        'show' => controller.method(:show)
      },
      'POST' => controller.method(:create),
      'PUT' => controller.method(:update),
      'DELETE' => controller.method(:destroy)
    }
  end
end

router = Router.new

router.init
