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

  erb_template <<-ERB
    <nav class="level box">
      <div class="level-item has-text-centered">
        <div>
          <p class="heading">Unique visitors</p>
          <p class="title"><%= @unique_visitors %></p>
        </div>
      </div>
      <div class="level-item has-text-centered">
        <div>
          <p class="heading">Total pageviews</p>
          <p class="title"><%= @pageviews %></p>
        </div>
      </div>
      <div class="level-item has-text-centered">
        <div>
          <p class="heading">Bounce rate</p>
          <p class="title"><%= @bounce_rate %> %</p>
        </div>
      </div>
    </nav>
  ERB
end
