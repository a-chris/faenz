class Devices < ViewComponent::Base
  def initialize(domain:, start_date:)
    @domain     = domain
    @start_date = start_date
    total_visits  = @domain.visits
                           .where('time_at > ?', start_date)
                           .map(&:from_device)
                           .compact
                           .size
    @series       = @domain.visits
                           .where('time_at > ?', start_date)
                           .map(&:from_device)
                           .tally
                           .transform_values { |v| ((v * 100).to_f / total_visits).round(2) }
  end
end
