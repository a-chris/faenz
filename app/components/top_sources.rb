class TopSources < BaseChart
  def initialize(domain:, start_date:)
    @domain     = domain
    @start_date = start_date
    @series     = @domain.visits
                         .where('time_at >= ?', start_date)
                         .pluck(:referrer)
                         .map { |r| r.gsub(%r{/$}, '') if r.present? }
                         .tally
                         .sort_by { |_, v| -v }
                         .first(10)
                         .to_h
                         .transform_keys { |k| k.nil? ? 'No referrer' : k }
  end
end
