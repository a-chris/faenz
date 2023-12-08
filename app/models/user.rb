class User < ApplicationRecord
  devise :database_authenticatable
  validates :username, uniqueness: true

  has_many :domains
end
