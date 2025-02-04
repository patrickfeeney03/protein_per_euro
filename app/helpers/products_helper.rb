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

  def manhandle_query_params(hash1, hash2)
    data_to_return = {}
    # hash1.each_pair do |pair|
    #   key = pair[0]
    #   data_to_return[pair[1]] = hash2[key]
    # end
    hash1.each_with_index do |each, idx|
      # key = pair[0]
      data_to_return[each] = hash2[idx]
    end
    data_to_return
  end
end
