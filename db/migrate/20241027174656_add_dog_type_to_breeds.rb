class AddDogTypeToBreeds < ActiveRecord::Migration[7.1]
  def change
    add_column :breeds, :dog_type, :string
  end
end
