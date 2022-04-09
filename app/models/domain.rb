class Domain < ApplicationRecord
  belongs_to :user
  has_many :visits

  validate :validate_base_url
  validate :validate_icon

  def name
    base_url.gsub(%r{^https://}, '').gsub(%r{/$}, '')
  end

  def icon_url
    icon || "#{base_url}/favicon.ico"
  end

  def with_protocol
    "https://#{base_url}"
  end

  def validate_base_url
    return errors.add(:base_url, 'is invalid') unless base_url.present?
    return errors.add(:base_url, 'should not start with http:// or https://') if base_url.match?(%r{^http(s?)://})
  end

  def validate_icon
    return errors.add(:icon, 'is invalid') unless icon.present?
    return errors.add(:icon, 'should start with http:// or https://') unless icon.match?(%r{^http(s?)://})
  end
end
