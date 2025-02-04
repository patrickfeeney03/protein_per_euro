class AddNormalisedProteinAndNormalisedCaloriesAndNormalisedFatsAndNormalisedCarbohydratesToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :normalised_protein, :float
    add_column :products, :normalised_calories, :float
    add_column :products, :normalised_fats, :float
    add_column :products, :normalised_carbohydrates, :float
  end
end
