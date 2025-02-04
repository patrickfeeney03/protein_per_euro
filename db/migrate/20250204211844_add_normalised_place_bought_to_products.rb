class AddNormalisedPlaceBoughtToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :normalised_place_bought, :string
  end
end
