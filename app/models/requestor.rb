class Requestor < ApplicationRecord
  has_many :invoices, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  # accepts_nested_attributes_for :invoices, allow_destroy: true, reject_if: lambda {|attributes| attributes['subject'].blank? and attributes['issued_on'].blank? and attributes['due_on'].blank? and attributes['api_status'].blank?}
end
