class AddNameAndDateBoughtToProduct < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :name, :string
    add_column :products, :date_bought, :datetime
  end
end
