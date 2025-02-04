task set_normalised_data: :environment do
  Product.all.each do |product|
    protein = product.protein
    carbohydrates = product.carbohydrates
    fats = product.fats
    calories = product.calories

    multiplier = 100.0 / product.weight_for_macros

    puts "Printing #{product}"
    product.normalised_protein = protein * multiplier unless protein.nil?
    product.normalised_carbohydrates = carbohydrates * multiplier unless carbohydrates.nil?
    product.normalised_fats = fats * multiplier unless fats.nil?
    product.normalised_calories = calories * multiplier unless calories.nil?

    product.save
  end
end