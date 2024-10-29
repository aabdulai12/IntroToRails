class BreedsController < ApplicationController
  def index
    @dogs = Dog.includes(:breed).all

    # Apply pagination
    @dogs = @dogs.page(params[:page]).per(10)

    # Handle search functionality
    if params[:category].present? && params[:search_term].present?
      case params[:category]
      when "Breed"
        @dogs = @dogs.joins(:breed).where("breeds.name LIKE ?", "%#{params[:search_term]}%")
      when "Owner"
        @dogs = @dogs.joins(:owner).where("owners.name LIKE ?", "%#{params[:search_term]}%")
      when "Country"
        @dogs = @dogs.joins(:breed).where("breeds.country LIKE ?", "%#{params[:search_term]}%")
      when "Dog Name"
        @dogs = @dogs.where("dogs.name LIKE ?", "%#{params[:search_term]}%")
      when "All" # Global search across multiple fields
        @dogs = @dogs.joins(:breed, :owner).where(
          "dogs.name LIKE :term OR breeds.name LIKE :term OR owners.name LIKE :term OR breeds.country LIKE :term",
          term: "%#{params[:search_term]}%"
        )
      end
    end
  end

  def show
    @breed = Breed.find(params[:id])
  end
end
