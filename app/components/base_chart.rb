class BaseChart < ViewComponent::Base
  attr_reader :series

  @@default_text_color = '#2f2f2f'
  @@primary_color = '#c24eb2'
  @@secondary_color = '#e6aa68'
  @@default_colors = [@@primary_color, @@secondary_color]

  @@options = {
    library: {
      scales: {
        x: { ticks: { color: @@primary_color, font: { family: 'Barlow' } } },
        y: { ticks: { color: @@primary_color, font: { family: 'Barlow' } } }
      }
    }
  }
end
