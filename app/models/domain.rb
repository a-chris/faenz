class Domain < ApplicationRecord
  belongs_to :user
  has_many :visits

  validate :validate_base_url

  before_save :clean_base_url
  before_save :set_default_icon

  # class methods

  def self.hotname(url)
    url = "https://#{url}" unless url.starts_with?('http')
    URI(url).host.gsub('www.', '')
  rescue => e
    puts e.message
    ''
  end

  # callbacks

  def clean_base_url
    self.base_url = self.class.hotname(base_url)
  end

  def set_default_icon
    self.icon ="#{self.base_url}/favicon.ico" if self.icon.blank?
  end

  # methods

  def name
    base_url.gsub(%r{^https://}, '').gsub(%r{/$}, '')
  end

  def icon_url
    icon || "#{base_url}/favicon.ico"
  end

  def validate_base_url
    return errors.add(:base_url, 'is empty') if base_url.blank?
    # return errors.add(:base_url, 'should not start with http:// or https://') if base_url.match?(%r{^http(s?)://})
  end
end
