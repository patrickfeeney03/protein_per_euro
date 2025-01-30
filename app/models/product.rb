class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  scope :sorted, -> { order(protein_per_euro: :desc) }
end
