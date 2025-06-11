class Income < ApplicationRecord
    belongs_to :district, optional: true
    has_many :outgoes
    validates :year, presence: true
    validates :category, presence: true
    validates :price, presence: true
end
