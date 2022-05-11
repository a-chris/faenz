Rails.application.config.middleware.insert_before 0, Rack::Cors, debug: true do
  allow do
    origins do |source|
      origin = source.gsub(%r{^https?://}, '').gsub('www.', '')
      allow  = Domain.find_by(base_url: origin).present?
      puts "blocked #{origin}" unless allow
      allow
    end
    resource '*', headers: :any, methods: %i[get post patch put options]
  end
end
