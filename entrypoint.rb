username = ENV['ADMIN_USERNAME']
password = ENV['ADMIN_PASSWORD']
User.create(username: username, password: password, role: 'admin')