class TopSources < BaseChart
  def initialize(domain:, start_date:)
    @domain     = domain
    @start_date = start_date
    @series     = @domain.visits
                         .where.not(referrer: nil)
                         .where('time_at > ?', start_date)
                         .pluck(:referrer)
                         .tally
                         .sort_by { |_, v| -v }
                         .first(10)
                         .to_h
  end
end
