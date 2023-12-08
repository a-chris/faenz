#
# Show only the visits coming from domains different from the current one
#
class TopSources < BaseChart
  def initialize(domain:, start_date:)
    @domain     = domain
    @start_date = start_date
    @series     = @domain.visits
                         .where("time_at >= ?", start_date)
                         .where.not("url like ?", "%#{domain.base_url}%")
                         .pluck(:referrer)
                         .map { |r| r.gsub(%r{/$}, "") if r.present? }
                         .tally
                         .sort_by { |_, v| -v }
                         .first(10)
                         .to_h
                         .transform_keys { |k| k.nil? ? "No referrer" : k }
  end

  erb_template <<-ERB
    <h2 class="title">Top sources</h2>
    <%= bar_chart @series, id: SecureRandom.hex(7), colors: @@default_colors, **@@options %>
  ERB
end
