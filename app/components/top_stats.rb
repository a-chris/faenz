class TopStats < ViewComponent::Base
  def initialize(domain:, start_date:)
    @domain     = domain
    @start_date = start_date
    @unique_visitors  = @domain.visits.pluck(:ip).uniq.size
    @pageviews        = @domain.visits.count
    single_page_session   = @domain.visits.pluck(:ip).tally.select { |k,v| v == 1 }.count
    @bounce_rate          = single_page_session.positive? ? ((single_page_session  * 100) / @domain.visits.count).round : 0
  end

  def single_page_session
    @domain.visits.pluck(:ip).tally
  end

  def multiple_page_session
    
  end
end
