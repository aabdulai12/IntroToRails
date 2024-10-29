class DogsController < ApplicationController
  # GET /dogs
  # This method retrieves and paginates dog records. 
  # If search parameters are provided, it filters results based on the selected category.
  def index
    # Pagination: Display 10 dogs per page.
    @dogs = Dog.page(params[:page]).per(10)

    # Check if both a category and search term are present for filtering.
    if params[:category].present? && params[:search_term].present?
      # Format the search term for partial matching
      search_term = "%#{params[:search_term]}%"

      # "All" Category: Broad search across multiple fields.
      # When 'All' is selected, this query searches for matches in the dog's name,
      # breed name, owner's name, and breed country.
      if params[:category] == "All"
        @dogs = @dogs.joins(:breed, :owner).where(
          "dogs.name LIKE :term OR breeds.name LIKE :term OR owners.name LIKE :term OR breeds.country LIKE :term",
          term: search_term
        )
      elsif params[:category] == "Breed"
        # Search within breeds only, based on the breed name
        @dogs = @dogs.joins(:breed).where("breeds.name LIKE ?", search_term)
      elsif params[:category] == "Owner"
        # Search within owners only, based on the owner's name
        @dogs = @dogs.joins(:owner).where("owners.name LIKE ?", search_term)
      elsif params[:category] == "Country"
        # Search within breeds based on the country of origin
        @dogs = @dogs.joins(:breed).where("breeds.country LIKE ?", search_term)
      elsif params[:category] == "Dog Name"
        # Search within dogs only, based on the dog's name
        @dogs = @dogs.where("dogs.name LIKE ?", search_term)
      end
    end
  end

  # GET /dogs/:id
  # This method retrieves a specific dog record based on its ID.
  def show
    @dog = Dog.find(params[:id])
  end
end
