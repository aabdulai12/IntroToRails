class Owner < ApplicationRecord
  has_many :dogs
  has_many :breeds, through: :dogs
  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def breed_count
    breeds.count
  end

  def breed_names
    breeds.any? ? breeds.pluck(:name).join(', ') : 'No breed'
  end

  # Breed Descriptions
  def breed_descriptions
    breeds.any? ? breeds.pluck(:description) : []
  end
end
