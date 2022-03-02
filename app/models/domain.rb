class Domain < ApplicationRecord
  has_many :visits

  validate :validate_base_url
  validate :validate_icon

  def icon_url
    icon || "#{base_url}/favicon.ico"
  end

  def validate_base_url
    return errors.add(:base_url, 'is invalid') unless base_url.present?
    return errors.add(:base_url, 'should start with http:// or https://') unless base_url.start_with?('http://')
  end

  def validate_icon
    return errors.add(:icon, 'is invalid') unless base_url.present?
    return errors.add(:icon, 'should start with http:// or https://') unless base_url.start_with?('http://')
  end
end
