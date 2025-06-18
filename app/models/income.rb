class Income < ApplicationRecord
    belongs_to :district, optional: true
    has_many :outgoes, dependent: :destroy
    validates :district_id, presence: true
    validates :year, presence: true, numericality:{only_integer: true, greater_than_or_equal_to: 6}
    validates :category, presence: true
    validates :price, presence: true, numericality:{only_integer: true, greater_than_or_equal_to: 0}, length: {maximum: 10}
    validates :memo, length: {maximum: 50}
end
