class VetVisit < ApplicationRecord
  belongs_to :dog
  has_one :breed, through: :dog
#validation added to the vet visit
  validates :visit_date, presence: true
  validates :description, presence: true
  validates :vet_clinic, presence: true

  before_create :set_vet_clinic

  private

  def set_vet_clinic
    self.vet_clinic = Faker::Company.name
  end
end
