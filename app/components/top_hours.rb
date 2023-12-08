class TopHours < BaseChart
  def initialize(domain:, start_date:)
    @domain     = domain
    @start_date = start_date
    all_hours = (0...23).to_h { |hour| [hour, 0] }
    @series = all_hours.merge(
      @domain.visits
      .where('time_at >= ?', @start_date)
      .pluck(:time_at)
      .map(&:to_datetime)
      .map(&:hour)
      .tally
    )
  end

  erb_template <<-ERB
    <h2 class="title">Top hours</h2>
    <%= column_chart @series, id: SecureRandom.hex(7), colors: @@default_colors, **@@options %>
  ERB
end
