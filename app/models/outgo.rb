class Outgo < ApplicationRecord
    belongs_to :income, optional: true
    validates :year, presence: true
    validates :category, presence: true
    validates :price, presence: true
    validates :memo, presence: true
end
