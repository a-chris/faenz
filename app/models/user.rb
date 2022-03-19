class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :validatable, :confirmable, :lockable, :timeoutable, :trackable, :registerable, :recoverable, :rememberable, :omniauthable
  devise :database_authenticatable
  validates :username, uniqueness: true

  has_many :domains
end
