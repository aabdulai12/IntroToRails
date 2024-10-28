# app/models/breed.rb
class Breed < ApplicationRecord
  has_many :dogs
# validation Added in breed
  validates :name, presence: true, uniqueness: true
  validates :group, presence: true
  validates :section, presence: true
  validates :country, presence: true
  validates :description, presence: true
  validates :dog_type, presence: true
  validates :food_to_avoid, presence: true

  before_validation :set_dog_type

  private

  def set_dog_type
    self.dog_type ||= Faker::Lorem.word
    self.food_to_avoid ||= Faker::Lorem.words(number: 3).join(', ')
    self.description ||= Faker::Lorem.paragraph
  end
end
