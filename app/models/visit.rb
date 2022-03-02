class Visit < ApplicationRecord
  belongs_to :domain

  serialize :geo, JSON

  def from_device
    return 'unknown' if width.blank?

    if width < 600
      'smartphone'
    elsif width < 768
      'tablet'
    elsif width < 992
      'laptop'
    else
      'large'
    end
  end
end
