class Domain < ApplicationRecord
  belongs_to :user
  has_many :visits

  validate :validate_base_url
  validate :validate_icon

  before_save :clean_base_url

  # CALLBACKS

  def clean_base_url
    self.base_url = self.class.hotname(base_url)
  end

  # CLASS METHODS

  def self.hotname(url)
    url = "https://#{url}" unless url.starts_with?("http")
    URI(url).host.gsub("www.", "")
  rescue StandardError => e
    puts e.message
    ""
  end

  # INSTANCE METHODS

  def name
    base_url.gsub(%r{^https://}, "").gsub(%r{/$}, "")
  end

  def validate_base_url
    return errors.add(:base_url, "is empty") if base_url.blank?
    errors.add(:base_url, "should start with http:// or https://") unless base_url.match?(%r{^http(s?)://})
  end

  def validate_icon
    if icon.present? && !icon.match?(%r{^http(s?)://})
      errors.add(:icon, "should start with http:// or https://")
    end
  end
end
