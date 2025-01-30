module ProductsHelper
  def format_number_table(number)
    if number == number.to_i
      number.to_i
    else
      sprintf("%g", "%.1f" % number)
    end
  end

  def display_value_for_100_grams(value, product)
    multiplier = 100.0 / product.weight_for_macros
    value * multiplier
  end
end
