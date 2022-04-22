class Visit < ApplicationRecord
  belongs_to :domain

  serialize :geo, JSON
  before_save :clean_referrer

  # callbacks

  def clean_referrer
    self.referrer = self.referrer&.gsub(%r{/$}, '')
  end

  # methods

  def from_device
    return 'unknown' if width.blank?

    if width < 600
      'smartphone'
    elsif width < 768
      'tablet'
    elsif width < 992
      'laptop'
    else
      'desktop'
    end
  end
end
