class OwnersController < ApplicationController
  def index
    @owners = Owner.page(params[:page]).per(10)

    # Add search functionality
    if params[:search_term].present?
      # Perform a search on the 'name' field for owners
      @owners = @owners.where("name LIKE ?", "%#{params[:search_term]}%")
    end
  end

  def show
    @owner = Owner.find(params[:id])
  end
end
