class Invoice < ApplicationRecord
  validates :subject, presence: true
  validates :issued_on, presence: true
  validates :due_on, presence: true
  validates :api_status
  enum api_status: { 完了: 0, 未連携:1 }
end
