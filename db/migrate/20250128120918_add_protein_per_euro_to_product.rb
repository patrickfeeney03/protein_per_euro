class AddProteinPerEuroToProduct < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :protein_per_euro, :float
  end
end
