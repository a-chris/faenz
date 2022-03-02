class TopPages < ViewComponent::Base
  def initialize(domain:, start_date:)
    @domain     = domain
    @start_date = start_date
    @series     = @domain.visits.where('time_at > ?', start_date).pluck(:url).tally
  end
end
