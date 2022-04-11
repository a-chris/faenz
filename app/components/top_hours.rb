class TopHours < BaseChart

  attr_reader :series

  def initialize(domain:, start_date:)
    @domain     = domain
    @start_date = start_date
    @series     = (0...23).to_h { |hour| [hour, 0] }.merge(@domain.visits.where('time_at >= ?', @start_date).pluck(:time_at).map(&:to_datetime).map(&:hour).tally)
  end
end
