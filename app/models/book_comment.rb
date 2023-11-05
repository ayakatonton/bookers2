class BookComment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  validates :comment, uniqueness: true, presence: true, length: { minimum: 3, maximum: 20 }
end