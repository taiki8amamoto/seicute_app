class Picture < ApplicationRecord
  belongs_to :invoice
  validates :name, presence: true
end
