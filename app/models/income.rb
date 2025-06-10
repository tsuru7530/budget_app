class Income < ApplicationRecord
    belongs_to :district, optional: true
    validates :year, presence: true
    validates :category, presence: true
    validates :price, presence: true
end
