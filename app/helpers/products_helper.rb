module ProductsHelper
  def format_number_table(number)
    if number == number.to_i
      number.to_i
    else
      sprintf("%g", number)
    end
  end
end
