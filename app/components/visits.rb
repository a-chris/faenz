class Visits < ViewComponent::Base
  def initialize(domain:, start_date:, options: {})
    @domain     = domain
    @start_date = start_date
    @options    = options
    @series     = @domain.visits.group_by_day(:time_at, range: start_date..Time.now).count

    if @options.delete(:show_only_line)
      @options.merge!(
        {
          points: false, legend: false,
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
end
