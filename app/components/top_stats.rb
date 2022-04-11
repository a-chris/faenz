class TopStats < BaseChart
  def initialize(domain:, start_date:)
    @domain     = domain
    @start_date = start_date

    visits                = @domain.visits.where('time_at >= ?', @start_date)
    @unique_visitors      = visits.pluck(:ip).uniq.size
    @pageviews            = visits.count
    single_page_session   = visits.pluck(:ip).tally.select { |_k, v| v == 1 }.count
    @bounce_rate          = single_page_session.positive? ? ((single_page_session * 100) / @pageviews).round : 0
  end

  def single_page_session
    @domain.visits.pluck(:ip).tally
  end
end
