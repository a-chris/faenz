class TopStats < ViewComponent::Base
  def initialize(domain:, start_date:)
    @domain     = domain
    @start_date = start_date

    ip_to_visits          = @domain.visits.pluck(:ip).tally
    single_page_session   = ip_to_visits.select { |k,v| v == 1 }.count
    multiple_page_session = ip_to_visits.select { |k,v| v > 1 }.count

    @unique_visitors  = @domain.visits.pluck(:ip).uniq.size
    @pageviews        = @domain.visits.count
    @bounce_rate      = single_page_session.positive? ? (single_page_session / multiple_page_session).round : 0
  end

  def single_page_session
    @domain.visits.pluck(:ip).tally
  end

  def multiple_page_session
    
  end
end
