class Invoice < ApplicationRecord
  validates :subject, presence: true
  validates :issued_on, presence: true
  validates :due_on, presence: true
  validates :due_on, presence: true
  validates :api_status, presence: true
  enum api_status: { 未連携: 0, 完了: 1 }
end
