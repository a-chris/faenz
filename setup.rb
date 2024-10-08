# To test with:
# ber db:drop db:create db:migrate
# ADMIN_USERNAME=admin ADMIN_PASSWORD=test DB=sqlite ber runner setup.rb -e production

rails_env = 'production'

if File.exist?('_first_run')
  puts 'Running for the first time'
  system("DISABLE_DATABASE_ENVIRONMENT_CHECK=1 RAILS_ENV=#{rails_env} bundle exec rails db:create")
  File.delete('_first_run')
else
  'Container already initialized.'
end

puts "Running with environment: #{rails_env}"
system("RAILS_ENV=#{rails_env} bundle exec rails db:migrate")
system("RAILS_ENV=#{rails_env} bundle exec rails s -d -e #{rails_env} -p 3000 -b 0.0.0.0")
system("tail -f log/#{rails_env}.log")
