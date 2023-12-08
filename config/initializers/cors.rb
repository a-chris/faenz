Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins do |source|
      next true if source.include?("localhost")

      origin = Domain.hotname(source)
      allow = Rails.cache.fetch(origin, expires_in: 1.year) do
        Domain.find_by(base_url: origin).present?
      end
      puts "blocked #{origin}" unless allow

      allow
    end
    resource "/api/*", headers: :any, methods: %i[post options]
  end
end
