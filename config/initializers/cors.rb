Rails.application.config.middleware.insert_before 0, Rack::Cors, debug: true do
  allow do
    origins do |source|
      if source.include?('api/event')
        origin = Domain.hotname(source)
        allow  = Domain.find_by(base_url: origin).present?
        puts "blocked #{origin}" unless allow
        allow
      else
        true
      end
    end
    resource '*', headers: :any, methods: %i[get post patch put options]
  end
end
