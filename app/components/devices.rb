class Devices < BaseChart
  def initialize(domain:, start_date:)
    @domain     = domain
    @start_date = start_date
    total_visits  = @domain.visits
                           .where('time_at >= ?', start_date)
                           .map(&:from_device)
                           .compact
                           .size
    @series       = @domain.visits
                           .where('time_at >= ?', start_date)
                           .map(&:from_device)
                           .tally
                           .transform_values { |v| ((v * 100).to_f / total_visits).round(2) }

    @options = @@options.merge(
      {
        library: {
          plugins: {
            datalabels: {
              color: @@default_text_color,
              labels: {
                title: {
                  font: {
                    weight: 'bold'
                  }
                }
              }
            }
          }
        }
      }
    )
  end

  erb_template <<-ERB
    <h2 class="title">Devices</h2>
    <%= pie_chart @series, id: SecureRandom.hex(7), suffix: "%", colors: [*@@default_colors, '#91c7b1', '#7796cb'], **@options %>
  ERB
end
