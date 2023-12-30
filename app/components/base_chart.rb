class BaseChart < ViewComponent::Base
  attr_reader :series

  @@default_text_color = '#2f2f2f'
  @@primary_color = '#AD66AD'
  @@secondary_color = '#e6aa68'
  @@default_colors = [@@primary_color, @@secondary_color]

  @@options = {
    library: {
      scales: {
        x: { ticks: { color: @@primary_color, font: { family: 'Poppins' } } },
        y: { ticks: { color: @@primary_color, font: { family: 'Poppins' } } }
      }
    }
  }
end
