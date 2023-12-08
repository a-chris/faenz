class Visits < BaseChart
  def initialize(domain:, start_date:, options: {})
    @domain     = domain
    @start_date = start_date
    @options    = @@options.merge(options)
    @series     = @domain.visits.group_by_day(:time_at, range: start_date..Time.now).count

    @options.merge!(points: false)

    if @options.delete(:show_line_only)
      @options.merge!(
        {
          legend: false,
          library: {
            scales: {
              x: { grid: { display: false, drawBorder: false }, ticks: { display: false } },
              y: { grid: { display: false, drawBorder: false }, ticks: { display: false } }
            }
          }
        }
      )
    end
  end

  erb_template <<-ERB
    <%= line_chart @series, id: SecureRandom.hex(7), curve: false, colors: @@default_colors, **@options %>
  ERB
end
