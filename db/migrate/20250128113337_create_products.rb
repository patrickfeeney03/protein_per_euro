class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.datetime :date_bought
      t.string :place_bought
      t.decimal :calories
      t.float :protein
      t.float :carbohydrates
      t.float :fats
      t.float :total_weight
      t.float :weight_for_macros
      t.float :price

      t.timestamps
    end
  end
end
