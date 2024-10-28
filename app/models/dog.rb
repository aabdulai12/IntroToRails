class Dog < ApplicationRecord
  belongs_to :breed, optional: true  # Temporarily allow null breed_id for seeding
  belongs_to :owner, optional: true  # Temporarily allow null owner_id for seeding
  has_many :vet_visits

  validates :name, presence: true, length: { minimum: 2 }
  validates :age, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 20 }
end
