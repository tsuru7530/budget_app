class Income < ApplicationRecord
    belongs_to :district, optional: true
    has_many :outgoes, dependent: :destroy
    validates :year, presence: true
    validates :category, presence: true
    validates :price, presence: true
end
