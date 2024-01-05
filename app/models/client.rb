class Client < ApplicationRecord
  has_many :accounts

  validates :first_name, :last_name, :email, :ssn, presence: true
end
