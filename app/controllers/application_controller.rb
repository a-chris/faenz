class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :init_user, only: :new

  def index
    if current_user.nil? && ENV['DEMO_MODE'] == 'true'
      redirect_to demo_path
    else
      redirect_to domains_path
    end
  end

  def init_user
    if User.count.zero?
      username = ENV['ADMIN_USERNAME']
      password = ENV['ADMIN_PASSWORD']
      puts "\n"
      puts '****** Creating a new admin user with the given username and password ******'
      puts "\n"
      User.create!(username: username, password: password, role: 'admin')
    end
  end
end
