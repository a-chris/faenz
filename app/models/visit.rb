class Visit < ApplicationRecord
  belongs_to :domain

  serialize :geo, coder: JSON

  before_save :clean_referrer

  # callbacks

  def clean_referrer
    self.referrer = referrer&.gsub(%r{/$}, "")
  end

  # methods

  def from_device
    return "unknown" if width.blank?

    if width < 600
      "smartphone"
    elsif width < 768
      "tablet"
    else
      "desktop"
    end
  end
end
