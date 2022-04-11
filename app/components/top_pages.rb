class TopPages < BaseChart
  attr_reader :series

  def initialize(domain:, start_date:)
    @domain     = domain
    @start_date = start_date
    @series     = @domain.visits
                         .where('time_at >= ?', start_date)
                         .pluck(:url)
                         .tally
                         .sort_by { |_, v| -v }
                         .first(10)
                         .to_h
                         .transform_keys { |k| k.gsub(Regexp.new("(.*)#{@domain.base_url}/?"), '/') }
  end
end
