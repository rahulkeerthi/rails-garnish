class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  belongs_to :category
  belongs_to :glass
  belongs_to :user
  validates :name, presence: true, uniqueness: true
end
