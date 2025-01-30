class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  scope :sorted, -> { order(protein_per_euro: :desc) }

  validates :total_weight, numericality: { greater_than_or_equal_to: 1 }
  validates :weight_for_macros, numericality: { greater_than_or_equal_to: 1 }
  validates :price, numericality: { greater_than_or_equal_to: 0.1 }
  validates :name, length: { minimum: 3 }
  validates :date_bought, presence: true
  validates :calories, numericality: { greater_than_or_equal_to: 0.1 }
  validates :protein, numericality: { greater_than_or_equal_to: 0.1 }
end
