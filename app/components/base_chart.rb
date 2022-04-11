class BaseChart < ViewComponent::Base
  @@default_text_color = '#2f2f2f'
  @@default_colors = ['#B33951', '#e6aa68']

  @@options = {
    library: {
      scales: {
        x: { ticks: { color: @@default_text_color, font: { family: 'Barlow', weight: 'bold' } } },
        y: { ticks: { color: @@default_text_color, font: { family: 'Barlow', weight: 'bold' } } }
      }
    }
  }
end
