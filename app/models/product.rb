class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  before_save :set_protein_per_euro

  scope :sorted, -> { order(protein_per_euro: :desc) }

  validates :name, length: { minimum: 3 }
  validates :date_bought, presence: true
  validates :place_bought, presence: true
  validates :protein, numericality: { greater_than_or_equal_to: 0.1 }
  validates :total_weight, numericality: { greater_than_or_equal_to: 1 }
  validates :weight_for_macros, numericality: { greater_than_or_equal_to: 1 }
  validates :price, numericality: { greater_than_or_equal_to: 0.1 }

  def calculate_protein_per_euro
    return 0 if self.weight_for_macros == 0
    servings = self.total_weight / self.weight_for_macros
    total_protein = servings * self.protein
    return total_protein if self.price == 0
    "%.2f" % (total_protein / self.price)
  end

  def set_protein_per_euro
    self.protein_per_euro = calculate_protein_per_euro
  end
end
