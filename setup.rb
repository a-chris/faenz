# ber db:drop db:create db:migrate
# ADMIN_USERNAME=admin ADMIN_PASSWORD=test ber runner entrypoint.rb 

if File.exist?('_first_run')
  username = ENV['ADMIN_USERNAME']
  password = ENV['ADMIN_PASSWORD']
  puts 'Creating a new admin user with the given username and password'
  User.create(username: username, password: password, role: 'admin')
  File.delete('_first_run')
else
  'Container already initialized.'
end

system('bundle exec rails server -d -b 0.0.0.0 -e production')
system('tail -f log/production.log')