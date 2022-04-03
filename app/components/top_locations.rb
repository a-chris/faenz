class TopLocations < ViewComponent::Base
  def initialize(domain:, start_date:)
    @domain     = domain
    @start_date = start_date
    @series     = @domain.visits
                         .map(&:geo)
                         .reject(&:blank?)
                         .map { |g| g['country'] }
                         .tally
                         .sort_by { |_, v| -v }
                         .to_h
                         .first(10)
  end
end
