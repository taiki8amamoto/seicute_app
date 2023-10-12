class Requestor < ApplicationRecord
  has_many :invoices, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  # def self.search_for(requestor)
  #   Requestor.find('requestor')
  # end
end
