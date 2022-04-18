# To test with:
# ber db:drop db:create db:migrate
# ADMIN_USERNAME=admin ADMIN_PASSWORD=test DB=sqlite ber runner setup.rb -e production

first_run = false
db_mode   = ENV['DB']
rails_env = db_mode == 'sqlite' ? 'production_sqlite' : 'production_mysql'

if File.exist?('_first_run')
  first_run = true
  system("DISABLE_DATABASE_ENVIRONMENT_CHECK=1 RAILS_ENV=#{rails_env} bundle exec rails db:create db:migrate")
  File.delete('_first_run')
else
  'Container already initialized.'
end

puts "Running with environment: #{rails_env}"
system("RAILS_ENV=#{rails_env} bundle exec rails s -d -e #{rails_env} -p 3000 -b 0.0.0.0")
system("tail -f log/#{rails_env}.log")
