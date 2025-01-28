class AddPlaceBoughtAndCaloriesAndProteinAndCarbohydratesAndFatsAndTotalWeightAndWeightForMacrosAndPriceToProduct < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :place_bought, :string
    add_column :products, :calories, :float
    add_column :products, :protein, :float
    add_column :products, :carbohydrates, :float
    add_column :products, :fats, :float
    add_column :products, :total_weight, :float
    add_column :products, :weight_for_macros, :float
    add_column :products, :price, :float
  end
end
