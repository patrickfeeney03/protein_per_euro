class Product < ApplicationRecord
  belongs_to :user

  scope :sorted, -> { order(protein_per_euro: :desc)}
end
