class Address < ApplicationRecord
  belongs_to :user
  validates :flat_no, :street, :pincode, :city, :state, :country, presence: true
end
