class BaseChart < ViewComponent::Base
  attr_reader :series

  @@default_text_color = '#2f2f2f'
  @@default_colors = ['#B33951', '#e6aa68']

  @@options = {
    library: {
      scales: {
        x: { ticks: { color: @@default_text_color, font: { family: 'BarlowSemiCondensed' } } },
        y: { ticks: { color: @@default_text_color, font: { family: 'BarlowSemiCondensed' } } }
      }
    }
  }
end
